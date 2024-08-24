require 'zip'
require 'tempfile'
require 'aws-sdk-s3'
require 'open3'
class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:like, :unlike]
  before_action :update_state
  before_action :set_user_repos

  def index
    @products = current_user.products.page(params[:page]).per(6)
  end

  def show
    @product = current_user.products.includes(:reviews, :languages).friendly.find(params[:id])
    @related_products = @product.related_products
    @reviews = @product.reviews.page(params[:page]).per(2)
    @languages = @product.languages
    @categories = @product.categories
  end

  def like
    @product.likes.create
    render json: { likes_count: @product.likes.count }
  end

  def unlike
    @product.likes.last&.destroy
    render json: { likes_count: @product.likes.count }
  end

  def edit
    @product = current_user.products.friendly.find(params[:id])
    @product_categories = @product.product_categories.includes(:category)
  end

  def update
    @product = current_user.products.friendly.find(params[:id])
    @product.update(product_params)
    @product.categories.destroy_all
    if params[:product][:category_ids].present?
      category_ids = params[:product][:category_ids][0].split(",").map(&:to_i)
      categories = Category.find(category_ids)
      @product.categories << categories
    end
    if params[:product][:product_url].present? && @product.folder.attachments.nil?
      repo_url = params[:product][:product_url]
      owner, repo_name = extract_owner_and_repo_name(repo_url)
      user_repos = octokit_client.repositories(nil, per_page: repositories_count)
      @archive_path = download_repository_as_zip(owner, repo_name, 'main', current_user.token)
    end
    @product.published = true
    @product.active = true

    @product.languages.destroy_all
    if params[:product][:language_ids].present?
      language_ids = params[:product][:language_ids][0].split(",").map(&:to_i)
      languages = Language.find(language_ids)
      @product.languages << languages
    else
      selected_language = Language.find_or_create_by(name: 'not_specified', image_name: 'html.png')
      @product.languages << selected_language
    end
    if @product.save
      render json: { message: 'Product was successfully Updated.', product_id: @product.slug }, status: :ok
    else
      render json: { message: @product.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def new
    @product = Product.new
    @filtered_repos = import_table
  end

  def create
    product_params_with_user = product_params.merge(user_id: current_user.id)
    params[:product_params_with_user] = product_params_with_user
    params[:user_id]=current_user.id
    if Product.find_by_url(params[:product][:product_url]&.strip).present? 
      render json: { message: 'Failed to create product. Repositry Aleady Exist.' }, status: :unprocessable_entity
    end    
    AddGitRepoWorkerJob.perform_async(params.to_json)
    render json: { message: 'Your file was large so we are finishing uploading it in the background. You will be notified when it is on the market.' }, status: :ok
  rescue => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def destroy
    @product = current_user.products.friendly.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: 'Product was successfully deleted.'
  end

  private

  def import_table
    private_repos = @user_repos.select { |repo| repo[:private] }
    product_urls = current_user.products.pluck("url")
    repo_hash = private_repos.map do |repo|
    {
      id: repo[:id],
      name: repo[:name],
      url: repo[:html_url],
      avatar_url: repo[:owner][:avatar_url],
      description: repo[:description],
      created_at: repo[:created_at]
    }
    end
    @filtered_repos = repo_hash.reject do |repo|
      product_urls.include?(repo[:url])
    end
    @filtered_repos = Kaminari.paginate_array(@filtered_repos).page(params[:page]).per(5)
  end

  def product_params
    params.require(:product).permit(
      :name, :description, :price, :active, :published, :category_ids,:preview_video_url, :video_file,
      covers: [],
      product_categories_attributes: [:id, :active],
      covers_attributes: [:id, :image]
    )
  end

  def extract_owner_and_repo_name(repo_url)
    parts = URI.parse(repo_url).path.split('/')
    [parts[1], parts[2]]
  end

  def octokit_client
    @octokit_client ||= Octokit::Client.new(access_token: current_user.token)
  end

  def repositories
    return @repositories if defined?(@repositories)

    Retriable.retriable(tries: 3, base_interval: 2.seconds) do
      all_repositories = octokit_client.repositories(
        nil, { per_page: repositories_count }
      )
      @repositories = all_repositories.select do |repository|
        repository.owner.login == github_login && repository.private?
      end
    end
  rescue => e
    Rails.logger.info(e.message)
    []
  end

  def github_login
    octokit_client.login
  end

  def update_state
    current_user.update(state: User.states[:seller])
  end

  def repositories_count
    octokit_client.user.public_repos + octokit_client.user.total_private_repos
  end

  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def set_user_repos
    @user_repos ||= octokit_client.repositories(nil, per_page: repositories_count)
  end

  def download_repository_as_zip(owner, repo, ref, token)
    begin
      zip_link = "https://github.com/#{owner}/#{repo}/archive/refs/heads/#{ref}.zip"
      temp_file = Tempfile.new([repo, '.zip'])
      
      curl_command = "curl -L -H 'Authorization: token #{token}' -o #{temp_file.path} #{zip_link}"
      
      stdout, stderr, status = Open3.capture3(curl_command)
      
      if status.success?
        puts "Successfully downloaded #{temp_file.path}"
        
        @product.folder.attach(
          io: File.open(temp_file.path), 
          filename: "#{repo}-#{ref}.zip", 
          content_type: 'application/zip'
        )
        puts "Successfully attached #{repo}-#{ref}.zip to the product"
        
        temp_file.path
      else
        puts "Failed to download ZIP: #{stderr}"
        nil
      end
    rescue => e
      puts "Exception occurred: #{e.message}"
      nil
    ensure
      temp_file.close
      temp_file.unlink
    end
  end
  
end

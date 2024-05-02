require 'zip'
require 'tempfile'
require 'aws-sdk-s3'
class ProductsController < ApplicationController
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  def index
    @products = current_user.products
  end

  def show
    @product = current_user.products.includes(:reviews, :languages).friendly.find(params[:id])
    @reviews = @product.reviews.includes(:user)
    @languages = @product.languages
    @categories = @product.categories
  end

  def edit
    @product = current_user.products.friendly.find(params[:id])
    @product_categories = @product.product_categories.includes(:category)
  end

  def update
    @product = current_user.products.friendly.find(params[:id])

    if @product.update(product_params)
      redirect_to product_path(@product)
    end
  end

  def new
    @product = Product.new
  end

  def create
    if params[:product][:repository_source] == "private"
      create_from_repo_url
    elsif params[:product][:repository_source] == "uploaded"
      product_params_with_user = product_params.merge(user_id: current_user.id)
      @product = Product.new(product_params_with_user)
      if params[:product][:category_ids].present?
        category_ids = params[:product][:category_ids][0].split(",").map(&:to_i)
        categories = Category.find(category_ids)
        @product.categories << categories
      end
      if params[:product][:language_ids].present?
        language_ids = params[:product][:language_ids][0].split(",").map(&:to_i)
        languages = Language.find(language_ids)
        @product.languages << languages
      else
        selected_language = Language.find_or_create_by(name: 'not_specified', image_name: 'html.png')
        @product.languages << selected_language
      end
      if @product.save!
        @product.folder.attach(params[:product][:folder])
        upload_folder_to_s3(params[:product][:folder]) if params[:product][:folder].present?
        render json: { message: 'Product was successfully created.', product_id: @product.id }, status: :created
      else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :price, :active, :published, :category_ids,:preview_video_url, :video_file,
      covers: [],
      product_categories_attributes: [:id, :active],
      covers_attributes: [:id, :image]
    )
  end

  def upload_folder_to_s3(folder)
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(ENV['AMAZON_BUCKET'])
    object_key = "#{SecureRandom.uuid}/folder.zip"
    obj = bucket.object(object_key)
    obj.upload_file(folder.path)
  end

  def create_from_repo_url
    product_params_with_user = product_params.merge(user_id: current_user.id)
    @product = Product.new(product_params_with_user)
    repo_url = params[:product][:repo_url]
    owner, repo_name = extract_owner_and_repo_name(repo_url)
    user_repos = octokit_client.repositories(nil, per_page: repositories_count)
    matching_repo = user_repos.find { |repo| repo.owner.login == owner && repo.name == repo_name }
    languages = Language.all.to_a
    respond_to do |format|
      begin
        if matching_repo
          language = matching_repo.language.present? ? languages.find { |lang| lang.name == matching_repo.language } : Language.find_or_create_by(name: 'not_specified', image_name: 'html.png')
          @product.name = matching_repo.name
          @product.description = matching_repo.description
          @product.url = matching_repo.html_url
          @product.repo_id = matching_repo.id
          @product.languages << language
          if @product.save!
            flash[:notice] = "Product created successfully from #{repo_url}."
            format.html { redirect_to product_path(@product) }
          else
            flash[:error] = @product.errors.full_messages.join(', ')
            format.html { redirect_back fallback_location: new_product_path, flash: { error: @product.errors.full_messages.join(', ') } }
          end
        else
          flash[:error] = "Failed to create product. Repository not found or does not belong to you."
          format.html { redirect_to new_product_path }
        end
      rescue PG::UniqueViolation => e
        flash[:error] = "Failed to create product. Repository already exists: #{e.message}"
        format.html { redirect_to new_product_path }
      rescue StandardError => e
        flash[:error] = "An error occurred: #{e.message}"
        format.html { redirect_to new_product_path }
      end
    end
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

  def repositories_count
    octokit_client.user.public_repos + octokit_client.user.total_private_repos
  end
end

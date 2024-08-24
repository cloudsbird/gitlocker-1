class AddGitRepoWorkerJob
  include Sidekiq::Job
  sidekiq_options :retry => 5, :dead => false

  def perform(params)
    params = JSON.parse(params).deep_symbolize_keys
    if Product.find_by_url(params[:product][:product_url]&.strip).present? 
      return
    end
    current_user = User.find(params[:user_id])
    octokit_client ||= Octokit::Client.new(access_token: current_user.token)
    repositories_count = octokit_client.user.public_repos + octokit_client.user.total_private_repos
    @product = Product.new(params[:product_params_with_user])
    @product.save
    if params[:product][:product_url].present?
      repo_url = params[:product][:product_url]
      owner, repo_name = extract_owner_and_repo_name(repo_url)
      user_repos = octokit_client.repositories(nil, per_page: repositories_count)
      matching_repo = user_repos.find { |repo| repo.owner.login == owner && repo.name == repo_name }

      if matching_repo
        @product.url = matching_repo.html_url
        @product.repo_id = matching_repo.id
        @archive_path = DownloadRepoAsZip.new.start(owner, repo_name, 'main', current_user.token, @product.id)
      else
        UserMailer.repo_added(@product, @product.user, "Failed to create product. Repository not found or does not belong to you. Github:- #{ params[:product][:product_url] }").deliver_now
        @product.destroy
        puts 'Failed to create product. Repository not found or does not belong to you.'
        return
      end
    end

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
    @product.published = true
    @product.active = true

    begin      
      if @product.save
        UserMailer.repo_added(@product, @product.user).deliver_now
      else
        UserMailer.repo_added(@product, @product.user, "Failed to create product for github:- #{params[:product][:product_url]}").deliver_now
        @product.destroy
      end
    rescue ActiveRecord::RecordNotUnique => e
      puts 'Failed to create product. Repositry Aleady Exist.'
    end
  rescue => e
    puts "Error:- #{e}"
  end

  def extract_owner_and_repo_name(repo_url)
    parts = URI.parse(repo_url).path.split('/')
    [parts[1], parts[2]]
  end
end

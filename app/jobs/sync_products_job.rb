class SyncProductsJob < ApplicationJob
  queue_as :default

  class GithubTokenMissingError < StandardError; end

  def perform(user_id)
    @user = User.find(user_id)
    raise GithubTokenMissingError, "User #{user.id} is missing github token" if user.token.blank?

    user.update!(syncing: true)

    languages = Language.all.to_a

    products = repositories.map do |repository|
      language = repository.language.present? ? languages.find { |lang| lang.name == repository.language } : Language.find_or_create_by(name: 'not_specified', image_name: 'html.png')

      product = Product.new(
        user: user,
        name: repository.name,
        description: repository.description,
        url: repository.html_url,
        repo_id: repository.id
      )
      product.languages << language
      product
    end

    Product.import!(
      products,
      on_duplicate_key_update: {
        conflict_target: [:repo_id],
        columns: [:name, :description, :url]
      },
      synchronize: products
    )

    user.update!(synced: true, syncing: false, seller: products.size > 0)
  end

  attr_reader :user

  private

  def octokit_client
    @octokit_client ||= Octokit::Client.new(access_token: user.token)
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

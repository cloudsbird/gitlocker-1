class SyncProductsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user = User.find(user_id)
    return unless user.synced?

    products = repositories.map do |repository|
      Product.new(
        user: user,
        name: repository.name,
        description: repository.description,
        url: repository.html_url
      )
    end

    Product.import!(products)
  end

  attr_reader :user

  private

  def octokit_client
    @octokit_client ||= Octokit::Client.new(access_token: user.token)
  end

  def repositories
    return @repositories if defined?(@repositories)

    all_repositories = octokit_client.repositories(
      github_login, { per_page: repositories_count }
    )
    @repositories = all_repositories.select do |repository|
      repository.owner.login == github_login && repository.private?
    end
  end

  def github_login
    octokit_client.login
  end

  def repositories_count
    octokit_client.user.public_repos + octokit_client.user.total_private_repos
  end
end

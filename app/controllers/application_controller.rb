class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :set_notifications
  rescue_from Octokit::Unauthorized, with: :octokit_unauthorized

  def visitor_user
    VisitorUser.new(session.id)
  end
  helper_method :visitor_user

  def show_sitemap
    require 'open-uri'
    url = 'https://s3.us-east-2.amazonaws.com/gitlocker/sitemaps/sitemap.xml'
    @sitemap_content = URI.open(url).read
    render xml: @sitemap_content
  rescue OpenURI::HTTPError
    render plain: 'Sitemap not found', status: :not_found
  end
  
  protected

  def after_sign_in_path_for(resource)
      if current_user && current_user&.seller?
        current_user.update(state: User.states[:buyer])
      end
      root_path
  end

  private

  def octokit_unauthorized(exception)
    render json: { message: 'Unauthorized access to GitHub API. Please authenticate.' }, status: :unprocessable_entity
  end

  def set_notifications
    if user_signed_in?
      @notifications_index = current_user.notifications.order(created_at: :desc).limit(5)
    else
      @notifications_index = []
    end
  end
end

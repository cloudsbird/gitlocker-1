class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Octokit::Unauthorized, with: :octokit_unauthorized

  def visitor_user
    VisitorUser.new(session.id)
  end
  helper_method :visitor_user
  
  protected

  def after_sign_in_path_for(resource)
      if current_user.seller?
        current_user.update(state: User.states[:buyer])
      end
      root_path
  end

  private

  def octokit_unauthorized(exception)
    render json: { message: 'Unauthorized access to GitHub API. Please authenticate.' }, status: :unprocessable_entity
  end
end

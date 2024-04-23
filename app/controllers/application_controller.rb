class ApplicationController < ActionController::Base
  include Pundit::Authorization

  def visitor_user
    VisitorUser.new(session.id)
  end
  helper_method :visitor_user
  
  protected

  def after_sign_in_path_for(resource)
      root_path
  end
end

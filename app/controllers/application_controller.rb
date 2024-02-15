class ApplicationController < ActionController::Base
  include Pundit::Authorization

  def visitor_user
    VisitorUser.new(session.id)
  end
  helper_method :visitor_user
end

class HomeController < ApplicationController
  def index
    redirect_to dashboard_path if user_signed_in? && current_user.token.present?

    if params[:search]
      redirect_to new_user_session_path
    end

    @languages = Language.all
  end

  def privacy
  end

  def terms
  end

  def refund_policy
  end

  def contact
  end

  def robots
    respond_to :text
  end
end

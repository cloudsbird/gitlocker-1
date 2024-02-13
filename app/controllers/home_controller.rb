class HomeController < ApplicationController
  def index
    redirect_to dashboard_path if user_signed_in?
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

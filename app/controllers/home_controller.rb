class HomeController < ApplicationController
  def index
    # redirect_to dashboard_path if user_signed_in? && current_user.token.present?

    @languages = Language.order(:name).limit(20)
    @recent_products = Product.published.recent.first(5)
    @popular_products = Product.order(purchases_count: :desc).first(5)
  end

  def privacy
  end

  def terms
  end

  def refund_policy
  end

  def contact
  end

  def explore
    current_user.update(state: User.states[:buyer])
    redirect_to root_path
  end

  def robots
    respond_to :text
  end
end

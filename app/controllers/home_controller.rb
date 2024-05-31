class HomeController < ApplicationController
  def index
    # redirect_to dashboard_path if user_signed_in? && current_user.token.present?
    redirect_to landing_page_path if !user_signed_in?

    @languages = Language.order(:name).limit(20)
    @categories = Category.order(:name).limit(20)
    @recent_products = Product.published.recent.exclude_purchased(current_user).first(5)
    @popular_products = Product.exclude_purchased(current_user).order(purchases_count: :desc).first(5)
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

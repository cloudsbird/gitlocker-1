class HomeController < ApplicationController
  def index
    redirect_to dashboard_path if user_signed_in? && current_user.token.present?

    @languages = Language.all
    @featured_products = Product.published.featured.first(5)
    @popular_products = Product.first(5)
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

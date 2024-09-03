module Marketplace
  class HomeController < ApplicationController
    def index
    # redirect_to dashboard_path if user_signed_in? && current_user.token.present?
    # redirect_to landing_page_path if !user_signed_in?
    @product_count = Product.count 
    @languages = Language.order(:name).limit(20)
    @categories = Category.order(:name).limit(20)
    @creators = User.order(total_earning: :desc).limit(20)
    @recent_products = Product.published.recent.exclude_purchased(current_user).first(15)
    @popular_products = Product.ordered_by_purchase_count.first(15)
    @free_products = Product.where("price_cents <= 0").order(created_at: :desc).first(15)
    @premium_products = Product.where("price_cents > 0").order(created_at: :desc).first(15)
  end
end
end

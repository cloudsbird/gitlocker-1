module Marketplace
  class HomeController < ApplicationController
    def index
      # redirect_to dashboard_path if user_signed_in? && current_user.token.present?
      # redirect_to landing_page_path if !user_signed_in?
      @product_count = Product.count 
      @category_count = Category.count 
      @languag_count = Language.count 
      @languages = Language.order(:name).limit(20)
      @categories = Category.order(:name).limit(20)
      @creators = User.order(total_earning: :desc).limit(20)
      @recent_products = Product.with_attached_covers.published.includes([:languages]).recent.exclude_purchased(current_user).first(15)
      @popular_products = Product.with_attached_covers.includes([:languages]).ordered_by_purchase_count.first(15)
      @free_products = Product.with_attached_covers.includes([:languages]).where("price_cents <= 0").order(created_at: :desc).first(15)
      @premium_products = Product.with_attached_covers.includes([:languages]).where("price_cents > 0").order(created_at: :desc).first(15)
      @featured_products = Product.with_attached_covers.includes([:languages]).where(featured: true)
    end
    def resources
    
    end
  end
end

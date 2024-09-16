module Marketplace
class LibraryController < ApplicationController
  def show
    @product = Product.includes(:languages, :categories).friendly.find(params[:id])
    @related_products = @product.related_products.with_attached_covers
    @reviews = @product.reviews.includes(:user).page(params[:page]).per(2)
    @in_cart = (current_user || visitor_user).products_in_cart.include?(@product) || false
    @languages = @product.languages
    @categories = @product.categories
    @cart_item = if @in_cart
                  CartItem.find_by(user: current_user, product: @product)
                 else
                   nil
                 end
    render "products/show"
  end
end
end

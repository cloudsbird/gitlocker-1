module Marketplace
class LibraryController < ApplicationController
  include ProductConcern
  def show
    @product = Product.includes(:languages, :categories).friendly.find(params[:id])
    @related_products = @product.related_products
    @reviews = @product.reviews.includes(:user).page(params[:page]).per(2)
    @in_cart = (current_user || visitor_user).products_in_cart.include?(@product) || false
    @languages = @product.languages
    @categories = @product.categories
    @cart_item = if @in_cart
                  CartItem.find_by(user: current_user, product: @product)
                 else
                   nil
                 end
    @directory_tree_json = fetch_product_directory_tree(@product)
    render "products/show"
  end
end
end

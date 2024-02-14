class LibraryController < ApplicationController
  def show
    @product = Product.friendly.find(params[:id])
    @reviews = @product.reviews.includes(:user)
    @in_cart = current_user&.products_in_cart&.include?(@product) || false
    @cart_item = if @in_cart
                  CartItem.find_by(user: current_user, product: @product)
                 else
                   nil
                 end
    render "products/show"
  end
end

class CartItemsController < ApplicationController
  def index
    @cart_items = (current_user || visitor_user).cart_items.includes(:product)
  end

  def create
    product = Product.find(params[:product_id])
    cart_item = CartItem.create(product: product, user: current_user, session_id: session.id)
    redirect_to library_path(product)
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    if cart_item.user && !CartItem.exists?(user: cart_item.user)
      redirect_to cart_items_path
    else
      redirect_back(fallback_location: library_path(cart_item.product))
    end
  end
end

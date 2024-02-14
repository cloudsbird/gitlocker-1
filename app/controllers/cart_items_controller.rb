class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    cart_item = CartItem.create(product: product, user: current_user)
    redirect_to library_path(product)
  end
end

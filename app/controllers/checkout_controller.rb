class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items.includes(:product)
  end
end

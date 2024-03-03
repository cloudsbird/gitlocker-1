class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items.includes(:product)
  end

  def create
    ActiveRecord::Base.transaction do
      purchases = current_user.cart_items.includes(:product).map do |cart_item|
        Purchase.new(
          user: current_user,
          product: cart_item.product,
          price_cents: cart_item.product.price_cents,
          price_currency: cart_item.product.price_currency
        )
      end
      Purchase.import(purchases, on_duplicate_key_ignore: true)
      current_user.reload.cart_items.destroy_all
    end

    redirect_to root_path
  end
end

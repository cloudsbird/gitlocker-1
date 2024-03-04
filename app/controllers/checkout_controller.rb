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
      Purchase.import(purchases, on_duplicate_key_ignore: true, synchronize: purchases)
      current_user.reload.cart_items.destroy_all
      PaymentJob.perform_now(
        user_id: current_user.id,
        stripe_token: params[:stripeToken],
        total: purchases.map(&:price_cents).sum
      )
    end

    redirect_to root_path
  end

  private

  def pay_for_stuff(total:)
    stripe_customer = if current_user.stripe_id.blank?
                          customer = Stripe::Customer.create(email: current_user.email)
                          current_user.update(stripe_id: customer.id)
                          customer
                        else
                          Stripe::Customer.retrieve(current_user.stripe_id)
                        end

    stripe_card = Stripe::Customer.create_source(
      stripe_customer.id,
      { source: params[:stripeToken] }
    )
    charge = Stripe::Charge.create(
      amount: total,
      currency: "usd",
      source: stripe_card.id,
      customer: stripe_customer.id
    )
  end
end

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

      total_cents = purchases.map(&:price_cents).sum

      transaction_fee_cents = (total_cents * 0.029 + 30).to_i  # Calculate the transaction fee
      total_with_fee = total_cents + transaction_fee_cents  # Calculate the total amount including the transaction fee

      line_items = purchases.map do |purchase|
        {
          price_data: {
            currency: purchase.price_currency,
            product_data: {
              name: purchase.product.name,
            },
            unit_amount: purchase.price_cents,
          },
          quantity: 1,
        }
      end

      line_items << {
        price_data: {
          currency: 'usd',  # Adjust currency if needed
          product_data: {
            name: 'Transaction Fee',
          },
          unit_amount: transaction_fee_cents,
        },
        quantity: 1,
      }

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: line_items,
        mode: 'payment',
        automatic_tax: { enabled: true },
        success_url: success_payment_url(total_cents: total_cents, purchases: purchases.to_json),
        cancel_url: cancel_payment_url,
      )


      redirect_to session.url, allow_other_host: true
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to cart_path
  end

  def success_payment
    ActiveRecord::Base.transaction do
      total_cents = params[:total_cents].to_i
      purchases_json = JSON.parse(params[:purchases])

      purchases = purchases_json.map { |purchase_attributes| Purchase.new(purchase_attributes) }

      payment = Payment.create(user: current_user, total_cents: total_cents)

      purchases.each { |purchase| purchase.payment = payment }

      Purchase.import(purchases, on_duplicate_key_ignore: true, synchronize: purchases)

      current_user.reload.cart_items.destroy_all
    end

    redirect_to purchases_url, notice: 'Payment successful! Your order has been placed.'
  end


  def cancel_payment
    flash[:error] = 'Payment canceled.'
    redirect_to checkout_url
  end
end

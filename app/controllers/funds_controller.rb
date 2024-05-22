class FundsController < ApplicationController
  def index
    @funds = current_user.total_sales_amount_in_dollars
  end

  def create
    seller = current_user
    balance_in_cents = (current_user.balance * 100).to_i
    amount = [balance_in_cents, 50].max
    stripe_token = params[:stripeToken]

    begin
      # Create a PaymentIntent directly without creating a Customer, since we're using a token
      payment_intent = Stripe::PaymentIntent.create({
        amount: amount,
        currency: 'usd',
        payment_method_types: ['card'],
        payment_method_data: {
          type: 'card',
          card: { token: stripe_token }
        },
        confirm: true,
        application_fee_amount: 0,
        transfer_data: {
          destination: seller.account.stripe_id 
        }
      })

      if payment_intent.status == 'succeeded'
        seller.update(balance: 0.00)
        redirect_to funds_path, notice: 'Payment successful!'
      else
        redirect_to funds_path, alert: 'Payment processing failed!'
      end
    rescue Stripe::StripeError => e
      Rails.logger.error "Stripe Error: #{e.message}"
      redirect_to funds_path, alert: 'Payment processing failed!'
    end
  end
end

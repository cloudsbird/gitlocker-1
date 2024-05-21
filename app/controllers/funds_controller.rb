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
      stripe_customer = Stripe::Customer.create(
        email: seller.email,
        source: stripe_token 
      )

      payment_intent = Stripe::PaymentIntent.create({
        amount: amount.to_i,
        currency: 'usd',
        payment_method_types: ['card'],
        customer: stripe_customer.id,
        payment_method: stripe_customer.default_source
      })

      payment_intent.confirm

      if payment_intent.status == 'succeeded'
        current_user.update(balance: 0.00)
        redirect_to funds_path, notice: 'Payout setup and processing successful!'
      else
        redirect_to funds_path, alert: 'Payout setup succeeded but processing failed!'
      end
    rescue Stripe::StripeError => e
      Rails.logger.error "Stripe Error: #{e.message}"

      redirect_to funds_path, alert: 'Payout setup and processing failed!'
    end
  end

end

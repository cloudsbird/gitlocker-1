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

      transfer = Stripe::Transfer.create({
        amount: amount,
        currency: 'usd',
        destination: seller.account.stripe_id,
        transfer_group: 'ORDER_95',
      })
      transfer_from_api = Stripe::Transfer.retrieve(transfer.id)

      if transfer_from_api.reversed
        redirect_to funds_path, alert: 'Payment processing failed!'
        puts "Transfer has been reversed"
      else
        seller.update(balance: 0.00)
        redirect_to funds_path, notice: 'Payment successful!'
      end
    rescue Stripe::InvalidRequestError, Stripe::CardError, Stripe::AuthenticationError, Stripe::APIConnectionError, Stripe::StripeError => e
      Rails.logger.error "Stripe Error: #{e.message}"
      redirect_to funds_path, alert: "Payment processing failed: #{e.message}"
    rescue StandardError => e
      Rails.logger.error "Unexpected Error: #{e.message}"
      redirect_to funds_path, alert: 'An unexpected error occurred. Please try again later.'
    end
  end
end

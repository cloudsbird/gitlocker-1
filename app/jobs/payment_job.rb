class PaymentJob < ApplicationJob
  queue_as :default

  def perform(user_id:, stripe_token:, total:)
    user = User.find(user_id)
    stripe_customer = if user.stripe_id.blank?
                        customer = Stripe::Customer.create(email: user.email)
                        user.update(stripe_id: customer.id)
                        customer
                      else
                        Stripe::Customer.retrieve(user.stripe_id)
                      end
    stripe_card = Stripe::Customer.create_source(
      stripe_customer.id,
      { source: stripe_token }
    )
    charge = Stripe::Charge.create(
      amount: total,
      currency: "usd",
      source: stripe_card.id,
      customer: stripe_customer.id
    )
  end
end

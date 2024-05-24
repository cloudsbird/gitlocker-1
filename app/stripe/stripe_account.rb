class StripeAccount
  include Rails.application.routes.url_helpers
  attr_reader :account

  def initialize(account)
    @account = account
  end

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  def financial_balances
    financial_account.balance
  end

  def payments_balances
    @payments_balances ||= Stripe::Balance.retrieve(header)
  end

  def payout
    amount = payments_balances.available.first.amount
    @payout ||= Stripe::Payout.create({
      amount: amount,
      currency: 'usd',
    }, header)
  end

  def create_account
    return if account.stripe_id.present?

    stripe_account = Stripe::Account.create({
      country: 'US',
      email: account.user.email,
      controller: {
        fees: {payer: 'application'},
        losses: {payments: 'application'},
        stripe_dashboard: {type: 'express'},
      },
    })

    account.update(stripe_id: stripe_account.id)
  end

  def onboarding_url
    Stripe::AccountLink.create({
      account: account.stripe_id,
      refresh_url: funds_url,
      return_url: funds_url,
      type: 'account_onboarding',
      collect: 'eventually_due',
    }).url
  end

  def header
    { stripe_account: account.stripe_id }
  end
end

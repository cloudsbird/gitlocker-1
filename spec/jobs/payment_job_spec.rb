require "rails_helper"

RSpec.describe PaymentJob, type: :job do
  let(:user) { create(:user) }
  let(:stripe_id) { SecureRandom.uuid }
  let(:stripe_token) { SecureRandom.uuid }
  let(:total) { 1212 }

  subject(:perform_now) do
    described_class.perform_now(
      user_id: user.id,
      stripe_token: stripe_token,
      total: total
    )
  end

  before do
    allow(Stripe::Customer).to receive(:create).and_return(double(id: stripe_id))
    allow(Stripe::Customer).to receive(:create_source).and_return(double(id: "card_id"))
    allow(Stripe::Charge).to receive(:create).and_return(double(id: "charge_id"))
  end

  describe "#perform" do
    it "updates user stripe_id" do
      expect { perform_now }.to change { user.reload.stripe_id }.from(nil).to(stripe_id)
    end
  end
end

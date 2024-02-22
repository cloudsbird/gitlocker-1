require "rails_helper"

RSpec.describe Purchase, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:product) }
  it { is_expected.to monetize(:price_cents) }
end

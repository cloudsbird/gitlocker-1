require "rails_helper"

RSpec.describe Payment, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:purchases).dependent(:destroy) }
  it { is_expected.to monetize(:total_cents) }
end

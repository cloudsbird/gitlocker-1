require "rails_helper"

RSpec.describe Payment, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to monetize(:total_cents) }
end

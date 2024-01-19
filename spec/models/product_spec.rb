require "rails_helper"

RSpec.describe Product, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to monetize(:price_cents) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:url) }
end

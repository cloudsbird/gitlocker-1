require "rails_helper"

RSpec.describe Product, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :language }
  it { is_expected.to have_many(:reviews).dependent(:destroy) }
  it { is_expected.to have_many(:purchases) }
  it { is_expected.to have_many(:product_categories).dependent(:destroy) }
  it { is_expected.to have_many(:categories).through(:product_categories) }
  it { is_expected.to monetize(:price_cents) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:url) }
end

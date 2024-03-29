require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to have_many(:products).dependent(:destroy) }
  it { is_expected.to have_many(:reviews).dependent(:destroy) }
  it { is_expected.to have_many(:cart_items).dependent(:destroy) }
  it { is_expected.to have_many(:products_in_cart).through(:cart_items).source(:product) }
  it { is_expected.to have_many(:purchases).dependent(:destroy) }
  it { is_expected.to have_many(:purchased_products).through(:purchases).source(:product) }
  it { is_expected.to have_many(:payments).dependent(:destroy) }
end

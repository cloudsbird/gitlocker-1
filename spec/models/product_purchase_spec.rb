require "rails_helper"

RSpec.describe ProductPurchase, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:purchase) }
end

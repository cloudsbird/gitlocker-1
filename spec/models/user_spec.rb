require "rails_helper"

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:products).dependent(:destroy) }
  it { is_expected.to have_many(:reviews).dependent(:destroy) }
end

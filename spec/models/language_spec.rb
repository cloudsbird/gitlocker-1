require "rails_helper"

RSpec.describe Language, type: :model do
  it { is_expected.to have_many(:products) }
  it { is_expected.to validate_presence_of(:name) }
end

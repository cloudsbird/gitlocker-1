require "rails_helper"

RSpec.describe SubscribedUser, type: :model do
  it { is_expected.to validate_presence_of(:email) }
end

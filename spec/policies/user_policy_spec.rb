require "rails_helper"

RSpec.describe UserPolicy, type: :policy do
  let(:user) { create(:user) }

  subject { described_class }

  permissions :edit? do
    it "grants access if the user is him/herself" do
      expect(subject).to permit(user, user)
    end

    it "denies access if the user is not him/herself" do
      other_user = create(:user)
      expect(subject).not_to permit(user, other_user)
    end
  end
end

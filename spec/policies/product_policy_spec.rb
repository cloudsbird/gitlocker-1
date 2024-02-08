require "rails_helper"

RSpec.describe ProductPolicy, type: :policy do
  let(:user) { create(:user) }

  subject { described_class }

  permissions :edit? do
    it "grants access if the product creator is the user" do
      product = build(:product, user: user)
      expect(subject).to permit(user, product)
    end

    it "denies access if the product creator is not the user" do
      product = create(:product)
      expect(subject).not_to permit(user, product)
    end
  end

  permissions :purchasable? do
    it "grants access if the product creator is not the user" do
      product = create(:product)
      expect(subject).to permit(user, product)
    end

    it "denies access if the product creator is the user" do
      product = create(:product, user: user)
      expect(subject).not_to permit(user, product)
    end
  end
end
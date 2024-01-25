require "rails_helper"

RSpec.describe "Users#ProductActivations", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "PUT update" do
    let!(:product) { create(:product, user: user) }

    let(:activate_product) do
      put product_activations_user_path(user), params: {
        product_ids: [product.id]
      }, headers: { "ACCEPT": "application/json" }
    end

    it "activates products" do
      expect do
        activate_product
      end.to change { product.reload.active? }.from(false).to(true)
    end

    it "completes registration for the user" do
      expect do
        activate_product
      end.to change { user.reload.registration_completed? }.from(false).to(true)
    end

    it "succeeds" do
      activate_product
      expect(response).to have_http_status(:success)
    end
  end
end

require "rails_helper"

RSpec.describe "Checkout", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET index" do
    it "succeeds" do
      get checkout_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    before do
      allow(PaymentJob).to receive(:perform_now)
      create(:cart_item, user: user)
    end

    it "creates new purchases" do
      expect do
        post checkout_path
      end.to change { Purchase.count }.from(0).to(1)
    end

    it "deletes user's cart items" do
      expect do
        post checkout_path
      end.to change { CartItem.count }.from(1).to(0)
    end

    it "redirects to root_path" do
      post checkout_path
      expect(response).to redirect_to(root_path)
    end
  end
end

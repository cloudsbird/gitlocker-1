require "rails_helper"

RSpec.describe "CartItems", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before { sign_in user }

  describe "GET index" do
    it "succeeds" do
      get marketplace_cart_items_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    let(:create_request) do
      post marketplace_cart_items_path, params: {
        product_id: product.id
      }
    end

    it "creates a new cart item" do
      expect { create_request }.to change { CartItem.count }.from(0).to(1)
    end

    it "redirects to marketplace_library_path" do
      create_request
      expect(response).to redirect_to marketplace_library_path(product)
    end
  end

  describe "DELETE destroy" do
    let!(:cart_item) { create(:cart_item, product: product, user: user) }
    let(:delete_request) do
      delete marketplace_cart_item_path(cart_item)
    end

    it "deletes the cart item" do
      expect { delete_request }.to change { CartItem.count }.from(1).to(0)
    end

    it "redirects to marketplace_cart_items_path" do
      delete_request
      expect(response).to redirect_to marketplace_cart_items_path
    end
  end
end

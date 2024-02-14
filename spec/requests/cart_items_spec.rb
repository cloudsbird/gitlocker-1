require "rails_helper"

RSpec.describe "CartItems", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before { sign_in user }

  describe "POST create" do
    let(:create_request) do
      post cart_items_path, params: {
        product_id: product.id
      }
    end

    it "creates a new cart item" do
      expect { create_request }.to change { CartItem.count }.from(0).to(1)
    end

    it "redirects to library_path" do
      create_request
      expect(response).to redirect_to library_path(product)
    end
  end

  describe "DELETE destroy" do
    let!(:cart_item) { create(:cart_item, product: product, user: user) }
    let(:delete_request) do
      delete cart_item_path(cart_item)
    end

    it "deletes the cart item" do
      expect { delete_request }.to change { CartItem.count }.from(1).to(0)
    end

    it "redirects to library_path" do
      delete_request
      expect(response).to redirect_to library_path(product)
    end
  end
end

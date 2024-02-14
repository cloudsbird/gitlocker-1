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
end

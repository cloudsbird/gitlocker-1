require "rails_helper"

RSpec.describe "Products", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET index" do
    it "succeeds" do
      get products_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "succeeds" do
      product = create(:product, user: user)
      get product_path(product)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET edit" do
    it "succeeds" do
      product = create(:product, user: user)
      get edit_product_path(product)
      expect(response).to have_http_status(:success)
    end
  end
end

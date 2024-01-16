require "rails_helper"

RSpec.describe "Products", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /index" do
    it "succeeds" do
      get products_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "succeeds" do
      get new_product_path
      expect(response).to have_http_status(:success)
    end
  end
end

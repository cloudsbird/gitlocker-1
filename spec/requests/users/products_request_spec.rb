require "rails_helper"

RSpec.describe "Users::Products", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET index" do
    it "succeeds" do
      get user_products_path(user), headers: { "ACCEPT": "application/json" }
      expect(response).to have_http_status(:success)
    end

    it "returns 3 products in response body" do
      create_list(:product, 3, user: user)
      get user_products_path(user), headers: { "ACCEPT": "application/json" }
      response_body = JSON.parse(response.body).with_indifferent_access
      expect(response_body[:data].size).to eq(3)
    end
  end
end

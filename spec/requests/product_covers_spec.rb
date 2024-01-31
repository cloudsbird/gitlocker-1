require "rails_helper"

RSpec.describe "ProductCovers", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user) }

  before { sign_in user }

  describe "POST create" do
    it "succeeds" do
      post product_covers_path(product), headers: { "ACCEPT": "text/vnd.turbo-stream.html" }
      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE destroy" do
    it "succeeds" do
      delete product_cover_path(product, 123), headers: { "ACCEPT": "text/vnd.turbo-stream.html" }
      expect(response).to have_http_status(:success)
    end
  end
end

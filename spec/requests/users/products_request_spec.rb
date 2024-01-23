require "rails_helper"

RSpec.describe "Users::Products", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET index" do
    it "succeeds" do
      get user_products_path(user), headers: { "ACCEPT": "text/vnd.turbo-stream.html" }
      expect(response).to have_http_status(:success)
    end
  end
end

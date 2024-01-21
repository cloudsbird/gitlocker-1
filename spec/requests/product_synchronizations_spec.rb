require "rails_helper"

RSpec.describe "ProductSynchronizations", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET show" do
    it "succeeds" do
      get product_synchronization_path(user), headers: { "ACCEPT": "application/json" }
      expect(response).to have_http_status(:success)
    end
  end
end

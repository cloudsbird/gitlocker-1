require "rails_helper"

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    context "when not logged in" do
      it "succeeds" do
        get marketplace_root_path
        expect(response).to have_http_status(:success)
      end
    end

    context "when logged in" do
      it "redirects to dashboard_path" do
        user = create(:user, token: SecureRandom.uuid)
        sign_in user
        get marketplace_root_path
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe "GET privacy" do
    it "succeeds" do
      get privacy_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET terms" do
    it "succeeds" do
      get terms_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET refund_policy" do
    it "succeeds" do
      get refund_policy_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET contact" do
    it "succeeds" do
      get contact_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET robots.txt" do
    it "succeeds" do
      get "/robots.txt"
      expect(response).to have_http_status(:success)
    end
  end
end

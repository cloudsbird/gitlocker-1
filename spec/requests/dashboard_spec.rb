require "rails_helper"

RSpec.describe "Dashboards", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /index" do
    context "when user has not finished registration" do
      it "redirects to complete_registrations_path" do
        get dashboard_path
        expect(response).to redirect_to complete_registrations_path
      end
    end

    context "when user has completed registration" do
      it "succeeds" do
        user.registration_completed!
        get dashboard_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end

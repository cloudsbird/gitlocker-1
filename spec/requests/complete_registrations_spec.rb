require "rails_helper"

RSpec.describe "CompleteRegistrations", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET index" do
    context "when user registration is pending" do
      it "succeeds" do
        get complete_registrations_path
        expect(response).to have_http_status(:success)
      end
    end

    context "when user registration is completed" do
      it "redirects to dashboard_path" do
        user.registration_completed!
        get complete_registrations_path
        expect(response).to redirect_to dashboard_path
      end
    end
  end

  pending do
    describe "PUT update" do
    end
  end
end

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

  describe "PUT update" do
    let(:params) {}
    let(:request) do
      put complete_registration_path, params: params
    end

    context "when user_type is customer" do
      let(:params) { { user_type: "customer"} }

      it "completes user registration" do
        expect do
          request
        end.to change { user.registration_completed? }.from(false).to(true)
      end

      it "redirects to dashboard_path" do
        request
        expect(response).to redirect_to dashboard_path
      end
    end

    context "when user_type is developer" do
      let(:params) { { user_type: "developer" } }

      it "does not complete user registration" do
        expect do
          request
        end.not_to change { user.registration_completed? }
      end

      it "redirects to complete_developer_registrations_pathjla" do
        request
        expect(response).to redirect_to complete_developer_registrations_path
      end
    end
  end
end

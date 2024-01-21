require "rails_helper"

RSpec.describe "CompleteDeveloperRegistrations", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET index" do
    before do
      allow(SyncProductsJob).to receive(:perform_later).and_return(true)
    end

    it "queues up SyncProductsJob" do
      expect(SyncProductsJob).to receive(:perform_later).with(user.id)
      get complete_developer_registrations_path
    end

    it "succeeds" do
      get complete_developer_registrations_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT update" do
    it "updates user's registration status" do
      expect { put complete_developer_registration_path }.to change {
        user.reload.registration_status
      }.from("registration_pending").to("registration_completed")
      expect(response).to redirect_to(dashboard_path)
    end
  end
end

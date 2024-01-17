require "rails_helper"

RSpec.describe "CompleteRegistrations", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET index" do
    it "succeeds" do
      get complete_registrations_path
      expect(response).to have_http_status(:success)
    end
  end
end

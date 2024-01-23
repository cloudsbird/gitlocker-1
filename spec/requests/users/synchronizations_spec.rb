require "rails_helper"

RSpec.describe "Users::Synchronizations", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET show" do
    it "succeeds" do
      get synchronizations_user_path(user), headers: { "ACCEPT": "application/json" }
      expect(response).to have_http_status(:success)
    end
  end
end

require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET edit" do
    it "succeeds" do
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end
end

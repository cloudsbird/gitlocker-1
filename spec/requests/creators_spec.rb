require "rails_helper"

RSpec.describe "Creators", type: :request do
  describe "GET index" do
    it "succeeds" do
      get creators_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "succeeds" do
      user = create(:user)
      get creator_path(user)
      expect(response).to have_http_status(:success)
    end
  end
end

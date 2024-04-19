require "rails_helper"

RSpec.describe "Browse", type: :request do
  describe "GET index" do
    it "succeeds" do
      get browse_path
      expect(response).to have_http_status(:success)
    end
  end
end

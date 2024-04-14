require "rails_helper"

RSpec.describe "SearchResults", type: :request do
  describe "GET index" do
    it "succeeds" do
      get search_path
      expect(response).to have_http_status(:success)
    end
  end
end

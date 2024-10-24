require "rails_helper"

RSpec.describe "Browse", type: :request do
  describe "GET index" do
    it "succeeds" do
      get marketplace_browse_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET popular" do
    it "succeeds" do
      get marketplace_browse_popular_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET featured" do
    it "succeeds" do
      get marketplace_browse_featured_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET languages" do
    it "succeeds" do
      language = create(:language)
      get marketplace_browse_languages_path(language_id: language.id)
      expect(response).to have_http_status(:success)
    end
  end
end

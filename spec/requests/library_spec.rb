require "rails_helper"

RSpec.describe "Library", type: :request do
  describe "GET show" do
    it "succeeds" do
      product = create(:product)
      get library_path(product)
      expect(response).to have_http_status(:success)
    end
  end
end

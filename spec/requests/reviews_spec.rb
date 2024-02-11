require "rails_helper"

RSpec.describe "Reviews", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before { sign_in user }

  describe "POST create" do
    let(:create_request) do
      post product_reviews_path(product), params: {
        review: {
          rating: 5,
          body: "This is excellent!"
        }
      }
    end

    it "creates a new review record" do
      expect { create_request }.to change { Review.count }.from(0).to(1)
    end

    it "redirects to library_path" do
      create_request
      expect(response).to redirect_to(library_path(product))
    end
  end
end

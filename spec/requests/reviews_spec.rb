require "rails_helper"

RSpec.describe "Reviews", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before { sign_in user }

  describe "GET new" do
    it "succeeds" do
      get new_library_review_path(product)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    let(:create_request) do
      post library_reviews_path(product), params: {
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

    it "sets average_rating for product" do
      allow(UpdateProductAverageRatingJob).to receive(:perform_later).and_return(true)
      create_request
      expect(UpdateProductAverageRatingJob).to have_received(:perform_later)
    end
  end
end

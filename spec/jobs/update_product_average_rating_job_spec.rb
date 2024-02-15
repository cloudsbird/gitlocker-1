require "rails_helper"

RSpec.describe UpdateProductAverageRatingJob, type: :job do
  let(:product) { create(:product) }

  it "updates the average rating of the product" do
    create(:review, product: product, rating: 2)
    create(:review, product: product, rating: 4)
    expect do
      described_class.perform_now(product.id)
    end.to change { product.reload.average_rating }.from(0).to(3)
  end
end

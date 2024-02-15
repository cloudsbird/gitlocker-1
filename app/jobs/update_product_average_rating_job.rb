class UpdateProductAverageRatingJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    product = Product.find(product_id)
    product.update(average_rating: product.reviews.average(:rating))
  end
end

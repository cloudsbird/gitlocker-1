class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    product = Product.friendly.find(product_id)
    @review = product.reviews.build(user_id: current_user.id)
  end

  def create
    product = Product.friendly.find(product_id)
    review = product.reviews.build(review_params.merge(user_id: current_user.id))

    if review.save
      redirect_to library_path(product)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end

  def product_id
    params[:library_id] || params[:product_id]
  end
end


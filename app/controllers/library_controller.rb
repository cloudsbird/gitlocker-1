class LibraryController < ApplicationController
  def show
    @product = Product.friendly.find(params[:id])
    @reviews = @product.reviews.includes(:user)
    render "products/show"
  end
end

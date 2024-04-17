class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products
  end

  def show
    @product = current_user.products.friendly.find(params[:id])
    @reviews = @product.reviews.includes(:user)
  end

  def edit
    @product = current_user.products.friendly.find(params[:id])
    @product_categories = @product.product_categories.includes(:category)
  end

  def update
    @product = current_user.products.friendly.find(params[:id])

    if @product.update(product_params)
      redirect_to product_path(@product)
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :price, :active, :published,
      covers: [],
      product_categories_attributes: [:id, :active]
    )
  end
end

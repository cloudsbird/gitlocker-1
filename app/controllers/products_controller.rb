class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = current_user.products
  end

  def show
    @product = current_user.products.friendly.find(params[:id])
  end

  def edit
    @product = current_user.products.friendly.find(params[:id])
  end
end
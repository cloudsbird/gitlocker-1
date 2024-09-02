module Marketplace
class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:slug])
    @products = @category.products.page(params[:page]).per(50)
    @products_count = Category.products.count
  end
end
end

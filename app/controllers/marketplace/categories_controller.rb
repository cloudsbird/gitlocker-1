module Marketplace
class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:slug])
    @products = Product.page(params[:page]).per(50)
  end
end
end

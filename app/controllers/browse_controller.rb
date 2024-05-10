class BrowseController < ApplicationController
  def index
    @products = Product.all
  end

  def popular
    @products = Product.order(purchases_count: :desc)
  end

  def recent
    @products = Product.recent
  end

  def languages
    @languages = Language.order(:name)
  end

  def categories
    @categories = Category.order(:name)
  end
end

class BrowseController < ApplicationController
  def index
    @products = Product.all
  end

  def popular
    @products = Product.order(purchases_count: :desc)
  end

  def featured
    @products = Product.featured
  end

  def languages
    @language = Language.find(params[:language_id])
    @products = Product.where(language_id: params[:language_id])
  end
end

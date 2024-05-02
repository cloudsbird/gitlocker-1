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
    @languages = Language.all
   if params[:language_id].present?
      @products = Product.includes(:language).where(language_id: params[:language_id])
    else
      @products = Product.includes(:language).all
    end
  end
end

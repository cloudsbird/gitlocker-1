module Marketplace
class BrowseController < ApplicationController
  def index
    @products = Product.exclude_purchased(current_user).filter_and_sort(filter_params).page(params[:page]).per(50)
  end

  def popular
    @products = Product.exclude_purchased(current_user).order(purchases_count: :desc).filter_and_sort(filter_params).page(params[:page]).per(50)
  end

  def recent
    @products = Product.exclude_purchased(current_user)
                       .filter_and_sort(filter_params)
                       .page(params[:page]).per(50)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def languages
    @languages = Language.order(:name).page(params[:page]).per(50)
  end

  def categories
    @categories = Category.order(:name).page(params[:page]).per(50)
  end

  private

  def filter_params
    params.permit(:category, :language, :sort_by)
  end
end
end

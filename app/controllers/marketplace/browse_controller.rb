module Marketplace
class BrowseController < ApplicationController
  def index
    @products = Product.exclude_purchased(current_user).page(params[:page]).per(10)
  end

  def popular
    @products = Product.exclude_purchased(current_user).order(purchases_count: :desc).page(params[:page]).per(10)
  end

  def recent
    @products = Product.exclude_purchased(current_user).recent.page(params[:page]).per(10)
  end

  def languages
    @languages = Language.order(:name).page(params[:page]).per(20)
  end

  def categories
    @categories = Category.order(:name).page(params[:page]).per(20)
  end
end
end

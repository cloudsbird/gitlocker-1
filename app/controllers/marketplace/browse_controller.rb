module Marketplace
class BrowseController < ApplicationController
  def index
    @products = Product.exclude_purchased(current_user)
  end

  def popular
    @products = Product.exclude_purchased(current_user).order(purchases_count: :desc)
  end

  def recent
    @products = Product.exclude_purchased(current_user).recent
  end

  def languages
    @languages = Language.order(:name)
  end

  def categories
    @categories = Category.order(:name)
  end
end
end

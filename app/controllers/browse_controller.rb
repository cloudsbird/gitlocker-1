class BrowseController < ApplicationController
  def index
    @products = Product.all
  end

  def popular
  end

  def featured
  end

  def languages
  end
end

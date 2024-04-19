class BrowseController < ApplicationController
  def index
    @products = Product.all
  end
end

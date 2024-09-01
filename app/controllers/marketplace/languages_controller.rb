# app/controllers/languages_controller.rb
module Marketplace
class LanguagesController < ApplicationController
  def show
    @language = Language.friendly.find(params[:slug])
    @products = apply_filters_and_sort(Product.exclude_purchased(current_user)).page(params[:page]).per(50)
  end
end
end

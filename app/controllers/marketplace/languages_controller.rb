# app/controllers/languages_controller.rb
module Marketplace
class LanguagesController < ApplicationController
  def show
    @language = Language.friendly.find(params[:slug])
    @products = @language.products.page(params[:page]).per(50)
  end
end
end

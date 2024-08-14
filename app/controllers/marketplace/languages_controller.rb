# app/controllers/languages_controller.rb
module Marketplace
class LanguagesController < ApplicationController
  def show
    @language = Language.friendly.find(params[:id])
  end
end
end

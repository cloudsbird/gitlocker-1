# app/controllers/languages_controller.rb

class LanguagesController < ApplicationController
  def show
    @language = Language.friendly.find(params[:slug])
  end
end

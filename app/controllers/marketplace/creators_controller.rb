module Marketplace
class CreatorsController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.friendly.find(params[:id])
    @products = @user.products.published
    @languages = @user.languages
    @categories = @user.categories
  end
end
end
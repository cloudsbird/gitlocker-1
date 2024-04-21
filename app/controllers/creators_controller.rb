class CreatorsController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.friendly.find(params[:id])
    @products = @user.products.published
  end
end

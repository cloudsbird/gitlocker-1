class CreatorsController < ApplicationController
  def index
    @users = User.sellers
  end

  def show
    @user = User.find(params[:id])
  end
end

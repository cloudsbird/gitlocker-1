class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(id: params[:user_id])
    @products = @user.products
  end

  def new
  end
end

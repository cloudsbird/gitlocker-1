class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    @sales = current_user.sales.includes(:product, :user)
  end

  def show
    @sale = current_user.sales.find(params[:id])
  end
end

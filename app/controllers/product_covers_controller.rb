class ProductCoversController < ApplicationController
  before_action :authenticate_user!

  def create
  end

  def destroy
  end

  private

  def product
    @product ||= Product.friendly.find(params[:id])
  end
end

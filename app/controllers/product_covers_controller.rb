class ProductCoversController < ApplicationController
  before_action :authenticate_user!
  before_action :product

  def create
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
  end

  private

  def product
    @product ||= Product.friendly.find(params[:product_id])
  end
end

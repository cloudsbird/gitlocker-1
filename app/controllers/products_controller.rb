require 'zip'
require 'tempfile'
require 'aws-sdk-s3'
class ProductsController < ApplicationController
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  def index
    @products = current_user.products
  end

  def show
    @product = current_user.products.friendly.find(params[:id])
    @reviews = @product.reviews.includes(:user)
  end

  def edit
    @product = current_user.products.friendly.find(params[:id])
    @product_categories = @product.product_categories.includes(:category)
  end

  def update
    @product = current_user.products.friendly.find(params[:id])

    if @product.update(product_params)
      redirect_to product_path(@product)
    end
  end

  def new
    @product = Product.new
  end

  def create
    product_params_with_user = product_params.merge(user_id: current_user.id)
    @product = Product.new(product_params_with_user)
    if @product.save!
      @product.folder.attach(params[:product][:folder])
      upload_folder_to_s3(params[:product][:folder]) if params[:product][:folder].present?
      render json: { message: 'Product was successfully created.', product_id: @product.id }, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :description, :price, :active, :published, :category_ids, :language_id,:preview_video_url, :video_file,
      covers: [],
      product_categories_attributes: [:id, :active],
      covers_attributes: [:id, :image]
    )
  end

  def upload_folder_to_s3(folder)
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(ENV['AMAZON_BUCKET'])
    object_key = "#{SecureRandom.uuid}/folder.zip"
    obj = bucket.object(object_key)
    obj.upload_file(folder.path)
  end
end

module Users
  class ProductsController < ApplicationController
    before_action :authenticate_user!

    def index
      @user = User.find(params[:user_id])
      @products = @user.products

      respond_to do |format|
        format.json do
          render json: ProductSerializer.new(@products).serializable_hash.to_json, status: :ok
        end
      end
    end
  end
end

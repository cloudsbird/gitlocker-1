module Users
  class ProductActivationsController < ApplicationController
    before_action :authenticate_user!

    def update
      @user = User.find(params[:id])
      @products = @user.products.where(id: product_ids_params[:product_ids])
      @products.update_all(active: true)
      @user.registration_completed!
      respond_to do |format|
        format.json do
          render json: {}, status: :ok
        end
      end
    end

    private

    def product_ids_params
      params.permit(product_ids: [])
    end
  end
end

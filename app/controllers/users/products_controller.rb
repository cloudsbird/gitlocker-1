module Users
  class ProductsController < ApplicationController
    before_action :authenticate_user!

    def index
      @user = User.find(params[:user_id])
      @products = @user.products

      respond_to do |format|
        format.turbo_stream
      end
    end
  end
end

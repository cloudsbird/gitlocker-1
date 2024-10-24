module Marketplace
module Users
  class ProductsController < ApplicationController
    before_action :authenticate_user!

    def index
      @user = User.friendly.find(params[:user_id])
      @products = @user.products

      respond_to do |format|
        format.turbo_stream
      end
    end
  end
end
end

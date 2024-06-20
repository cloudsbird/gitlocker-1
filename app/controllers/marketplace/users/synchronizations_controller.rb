module Marketplace
module Users
  class SynchronizationsController < ApplicationController
    before_action :authenticate_user!

    def show
      @user = User.friendly.find(params[:id])

      respond_to do |format|
        format.json do
          render json: UserSerializer.new(@user).serializable_hash.to_json, status: :ok
        end
      end
    end
  end
end
end

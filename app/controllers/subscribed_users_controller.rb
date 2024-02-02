class SubscribedUsersController < ApplicationController
  def create
    subscribed_user = SubscribedUser.create(email_params)
    respond_to do |format|
      format.json do
        render json: subscribed_user.to_json, status: 201
      end
    end
  end

  private

  def email_params
    params.permit(:email)
  end
end

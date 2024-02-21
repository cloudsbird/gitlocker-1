class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = User.find(params[:id])
    authorize(@user)
  end

  def update
    @user = User.find(params[:id])
    authorize(@user)
    @user.update(user_params)
    redirect_to edit_user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :name, :profile_picture)
  end
end

class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @user = User.friendly.find(params[:id])
    @languages = @user.languages
    @categories = @user.categories
  end

  def edit
    @user = User.friendly.find(params[:id])
    authorize(@user)
  end

  def update
    @user = User.friendly.find(params[:id])
    authorize(@user)
    if @user.update(user_params)
      if params[:user][:category_ids].present?
        @user.categories = Category.where(id: params[:user][:category_ids])
      else
        @user.categories.clear
      end
      if params[:user][:language_ids].present?
        @user.languages = Language.where(id: params[:user][:language_ids])
      else
        @user.languages.clear
      end
      redirect_to @user, notice: 'Profile was successfully updated.'
    else
      redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :name, :profile_picture, :bio, :location, :company, :facebook_url, :instagram_url, :linkedin_url, :youtube_url)
  end
end

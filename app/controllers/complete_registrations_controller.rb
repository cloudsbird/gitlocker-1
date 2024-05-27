class CompleteRegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_to_dashboard, if: -> { current_user.registration_completed? }

  def index
  end

  def update
    if user_type == "customer"
      current_user.registration_completed!
      redirect_to funds_path
    else
      redirect_to complete_developer_registrations_path
    end
  end

  private

  def redirect_to_dashboard
    redirect_to funds_path
  end

  def user_type
    params.permit(:user_type)[:user_type]
  end
end

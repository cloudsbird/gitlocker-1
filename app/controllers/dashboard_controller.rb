class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to complete_registrations_path if current_user.registration_pending?
  end
end

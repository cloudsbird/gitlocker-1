class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to complete_registrations_path if current_user.registration_pending?

    @products = current_user.products.order(created_at: :desc).limit(3)
  end
end

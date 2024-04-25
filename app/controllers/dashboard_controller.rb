class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # redirect_to complete_registrations_path if current_user.registration_pending?

    @products = current_user.products.order(created_at: :desc).limit(3)
    @sales = current_user.sales.includes(:product).order(created_at: :desc).limit(5).group_by do |sale|
      sale.created_at.to_date
    end
  end

  def seller_dashboard
    current_user.update(state: User.states[:seller])
    redirect_to root_path
  end
end

class CompleteDeveloperRegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_to_dashboard, if: -> { current_user.registration_completed? }

  def index
    SyncProductsJob.perform_later(current_user.id) unless current_user.synced?
  end

  def update
  end

  private

  def redirect_to_dashboard
    redirect_to dashboard_path
  end
end

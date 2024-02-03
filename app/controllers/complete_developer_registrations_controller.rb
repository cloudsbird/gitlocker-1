class CompleteDeveloperRegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_to_dashboard, if: -> { current_user.registration_completed? }

  def index
    if current_user.token.present?
      SyncProductsJob.perform_now(current_user.id)
      render "index_synced"
    else
      render "index_oauth"
    end
  end

  def update
    current_user.registration_completed!
    redirect_to dashboard_path
  end

  private

  def redirect_to_dashboard
    redirect_to dashboard_path
  end
end

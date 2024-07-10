# Example controller action to render notifications
module Marketplace
class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def mark_as_read
    notification = Notification.find(params[:id])
    notification.read!
    redirect_to root_path, notice: 'Notification marked as read.'
  end

   def mark_all_as_read
      current_user.notifications.unread.update_all(read_at: Time.zone.now)
      redirect_to marketplace_notifications_path, notice: 'All notifications marked as read.'
    end
end
end

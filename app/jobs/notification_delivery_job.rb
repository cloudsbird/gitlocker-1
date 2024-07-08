# app/jobs/notification_delivery_job.rb
class NotificationDeliveryJob < ApplicationJob
  queue_as :default

  def perform(notification)
    # Deliver the notification
    notification.deliver!
  end
end

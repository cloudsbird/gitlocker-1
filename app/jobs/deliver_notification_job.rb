# Example of a job to deliver the notification
class DeliverNotificationJob < ApplicationJob
  queue_as :default

  def perform(notification_id)
    notification = PurchaseNotification.find(notification_id)
    notification.deliver # You might need to define the deliver method based on Noticed gem documentation
  end
end
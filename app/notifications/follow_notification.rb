# app/notifications/follow_notification.rb
class FollowNotification < Noticed::Event
  self.table_name = 'notifications'

  belongs_to :recipient, polymorphic: true
  belongs_to :follower, polymorphic: true

  after_initialize :set_notification_message

  def message
    params[:message]
  end

  private

  def set_notification_message
    self.params ||= {}
    self.params[:message] ||= "Hello #{recipient.name}, you have a new follower: #{follower.name}."
  end
end

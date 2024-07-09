# app/notifications/balance_notification.rb
class BalanceNotification < Noticed::Event
  self.table_name = 'notifications'

  belongs_to :recipient, polymorphic: true

  after_initialize :set_notification_message

  def message
    params[:message]
  end

  private

  def set_notification_message
    self.params ||= {}
    self.params[:message] ||= "Hello #{recipient.name}, your account balance is now #{recipient.balance}."
  end
end

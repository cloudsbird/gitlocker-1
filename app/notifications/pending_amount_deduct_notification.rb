# app/notifications/refund.rb
class PendingAmountDeductNotification < Noticed::Event
  self.table_name = 'notifications'

  belongs_to :recipient, polymorphic: true
  belongs_to :product

  after_initialize :set_notification_message

  def message
    params[:message]
  end

  private

  def set_notification_message
    self.params ||= {}
    self.params[:message] ||= "Your Amount $#{product.price_cents/100} against Product #{product.name} is Deducted. Contact Admin for more information cody@gitlocker.com"
  end
end

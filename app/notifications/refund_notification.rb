# app/notifications/refund.rb
class RefundNotification < Noticed::Event
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
    self.params[:message] ||= "Your Refund against Product #{product.name} of amount $#{product.price_cents/100} is Refuded to your stripe account."
  end
end

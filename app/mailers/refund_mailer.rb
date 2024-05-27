class RefundMailer < ApplicationMailer
  def notify_admin(refund, user)
    @refund = refund
    @user = user
    mail(to: 'cody@gitlocker.com', subject: 'New Refund Request', from: 'support@gitlocker.com')
  end
end
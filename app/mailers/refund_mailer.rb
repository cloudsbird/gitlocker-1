class RefundMailer < ApplicationMailer
  def notify_admin(refund, user)
    @refund = refund
    @user = user
    mail(to: 'cody@gitlocker.com', subject: 'New Refund Request', from: 'support@gitlocker.com')
  end

  def notify_buyer(refund, user)
    @refund = refund
    @user = user
    mail(to: @user.email, subject: 'Approved Refund Request', from: 'support@gitlocker.com')
  end

  def notify_seller(refund, user)
    @refund = refund
    @user = user
    mail(to: @refund.product.user.email, subject: "Refund Request for #{@refund.product.name} : Action Required", from: 'support@gitlocker.com')
  end

  def reject_refund_request(refund, user)
    @refund = refund
    @user = user
    mail(to: @user.email, subject: 'Deny Refund Request', from: 'support@gitlocker.com')
  end
end
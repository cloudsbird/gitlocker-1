class UserMailer < ApplicationMailer
  def repo_added(product, user, error = nil)
    @product = product
    @user = user
    @error = error
    subject = @error ? 'Failed to create product' : 'Product added successfully'
    mail(to: @user.email, subject: subject, from: 'support@gitlocker.com')
  end
end
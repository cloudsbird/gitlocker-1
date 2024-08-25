class UserMailer < ApplicationMailer
  def repo_added(product, user, product_url, error = nil)
    @product = product
    @user = user
    @error = error
    @product_url = product_url
    subject = @error ? 'Failed to create product' : 'Product added successfully'
    mail(to: @user.email, subject: subject, from: 'support@gitlocker.com')
  end
end
class UserMailer < ApplicationMailer
  def repo_added(product, user, action, product_url, error = nil)
    @product = product
    @user = user
    @error = error
    @product_url = product_url
    @action = action
    subject = @error ? 'Failed to create product' : "Product #{action} successfully"
    mail(to: @user.email, subject: subject, from: 'support@gitlocker.com')
  end
end
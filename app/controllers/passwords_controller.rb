# app/controllers/passwords_controller.rb
class PasswordsController < Devise::PasswordsController
  def new
    super
  end

  def create
    super
  end

  def show_instructions
    render 'show_instructions'
  end

  protected

  def after_sending_reset_password_instructions_path_for(resource_name)
    user_email = resource.email
    "/password_instructions?email=#{user_email}"
  end
end

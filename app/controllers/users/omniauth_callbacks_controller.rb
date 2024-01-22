# Class to validate omniauth callbacks
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Github"
      SyncProductsJob.perform_later(current_user.id)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.github_data"] = request.env["omniauth.auth"].except("extra") # Removing extra cause it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end
end

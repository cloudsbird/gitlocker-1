module Users
  class RegistrationsController < Devise::RegistrationsController
    include DeviseCallbacks
    def create
      super do |resource|
        if resource.persisted?
          flash[:notice] = "Welcome! You have signed up successfully. Please check your email for confirmation."
        end
      end
    end

    def signup_success
    end

    protected

    def after_inactive_sign_up_path_for(resource)
      user_email = resource.email
      signup_success_path
      "/signup_success?email=#{user_email}"
    end
  end
end

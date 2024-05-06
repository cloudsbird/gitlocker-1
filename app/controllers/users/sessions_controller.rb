module Users
  class SessionsController < Devise::SessionsController
    include DeviseCallbacks
    def new
      @github_email = cookies[:github_email]
    end
  end
end

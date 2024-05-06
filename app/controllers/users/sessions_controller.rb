module Users
  class SessionsController < Devise::SessionsController
    include DeviseCallbacks
    def new
      @github_email = session[:github_email]
     puts "GitHub email retrieved from session: #{@github_email}"
    end
  end
end

module Users
  class SessionsController < Devise::SessionsController
    include DeviseCallbacks
  end
end

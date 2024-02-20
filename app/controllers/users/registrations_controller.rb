module Users
  class RegistrationsController < Devise::RegistrationsController
    include DeviseCallbacks
  end
end

class UserSerializer
  include JSONAPI::Serializer

  attributes  :id, :email, :status, :username, :name, :registration_status
end

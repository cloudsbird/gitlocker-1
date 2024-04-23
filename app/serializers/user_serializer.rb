class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :email, :username, :name, :registration_status, :synced,
             :syncing
end

class ProductSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :url, :description
end

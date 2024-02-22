class Purchase < ApplicationRecord
  monetize :price_cents

  belongs_to :user
  belongs_to :product
end

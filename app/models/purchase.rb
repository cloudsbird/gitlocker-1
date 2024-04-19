class Purchase < ApplicationRecord
  monetize :price_cents

  belongs_to :user
  belongs_to :product, counter_cache: true
  belongs_to :payment, optional: true
end

class Purchase < ApplicationRecord
  monetize :price_cents

  belongs_to :user
  belongs_to :product
  belongs_to :payment, optional: true

  has_many :sales
end

class CartItem < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :product

  validates :product_id, uniqueness: { scope: :user_id }
end

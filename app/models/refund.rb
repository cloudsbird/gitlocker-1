# Rails example
class Refund < ApplicationRecord
  belongs_to :product
  has_one_attached :stripe_transaction_screenshot
  
  validates :description, presence: true
end

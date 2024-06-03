# Rails example
class Refund < ApplicationRecord
  belongs_to :product
  has_one_attached :stripe_transaction_screenshot, dependent: :destroy
  
  validates :description, presence: true
  validates :status, inclusion: { in: %w[pending approved denied completed] }

  def approve!
    update!(status: 'completed')
  end

  def deny!
    update!(status: 'denied')
  end

  def self.ransackable_associations(auth_object = nil)
    ["product"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "product_id", "stripe_transaction_screenshot_metadata", "status"] # Add "stripe_transaction_screenshot_metadata" for searching by attachment metadata
  end
end

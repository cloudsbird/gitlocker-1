class Payment < ApplicationRecord
  monetize :total_cents

  belongs_to :user
  has_many :purchases, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["stripe_charge_id", "user_email"]
  end

  def user_email
    user.email
  end
end

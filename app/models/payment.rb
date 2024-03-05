class Payment < ApplicationRecord
  monetize :total_cents

  belongs_to :user
  has_many :purchases, dependent: :destroy
end

class Payment < ApplicationRecord
  monetize :total_cents

  belongs_to :user
end

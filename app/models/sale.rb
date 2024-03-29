class Sale < ApplicationRecord
  belongs_to :purchase
  belongs_to :user
end

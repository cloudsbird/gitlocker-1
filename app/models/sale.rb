class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :purchase
  belongs_to :creator, class_name: "User"
end

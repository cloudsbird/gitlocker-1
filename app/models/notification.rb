class Notification < ApplicationRecord
  self.inheritance_column = :_type_disabled # To avoid conflicts with 'type' column
  belongs_to :recipient, polymorphic: true
  belongs_to :product

end

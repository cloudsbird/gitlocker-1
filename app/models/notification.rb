class Notification < ApplicationRecord
  self.inheritance_column = :_type_disabled # To avoid conflicts with 'type' column
  belongs_to :recipient, polymorphic: true

  def balance_over_100(balance)
    params = {
      balance: balance
    }
    self.create(recipient: recipient, params: params)
  end
end

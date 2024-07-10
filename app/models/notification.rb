class Notification < ApplicationRecord
  self.inheritance_column = :_type_disabled # To avoid conflicts with 'type' column
  belongs_to :recipient, polymorphic: true
  belongs_to :product
  scope :unread, -> { where(read_at: nil) }

  def read!
    update(read_at: Time.zone.now)
  end

end

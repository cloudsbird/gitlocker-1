class AddBuyerToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :buyer_id, :integer
    add_column :notifications, :buyer_type, :string
  end
end

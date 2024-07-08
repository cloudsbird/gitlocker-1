class AddProductIdToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_reference :notifications, :product, foreign_key: true
  end
end

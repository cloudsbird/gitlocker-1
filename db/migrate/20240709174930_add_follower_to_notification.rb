class AddFollowerToNotification < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :follower_id, :integer
    add_column :notifications, :follower_type, :string
  end
end

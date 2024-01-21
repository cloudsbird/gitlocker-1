class AddSyncedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :synced, :boolean, default: false, null: false
  end
end

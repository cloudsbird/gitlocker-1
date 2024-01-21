class AddSyncingToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :syncing, :boolean, default: false, null: false
  end
end

class AddRegistrationStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :registration_status, :integer, default: 0, null: false
  end
end

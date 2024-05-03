class AddSellerToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :seller, :boolean, default: false, null: false
  end
end
class AddUserUrlUniqueIndexToProducts < ActiveRecord::Migration[7.1]
  def change
    add_index :products, [:user_id, :url], unique: true
  end
end

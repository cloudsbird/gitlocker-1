class AddUserProductUniqueIndexToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_index :purchases, [:user_id, :product_id], unique: true
  end
end

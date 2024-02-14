class AddUniquenessConstraintToUserIdProductItToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_index :cart_items, [:user_id, :product_id], unique: true
  end
end

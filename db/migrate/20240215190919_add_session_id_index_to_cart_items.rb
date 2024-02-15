class AddSessionIdIndexToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_index :cart_items, [:session_id, :product_id], unique: true
  end
end

class RemoveProductsUserIdUrlUniqueIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :products, [:user_id, :url]
  end
end

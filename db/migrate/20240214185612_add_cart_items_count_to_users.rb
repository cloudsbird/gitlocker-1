class AddCartItemsCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :cart_items_count, :integer, default: 0, null: false
  end
end

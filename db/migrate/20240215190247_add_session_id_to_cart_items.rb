class AddSessionIdToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :session_id, :string
  end
end

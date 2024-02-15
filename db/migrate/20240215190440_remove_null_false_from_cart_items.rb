class RemoveNullFalseFromCartItems < ActiveRecord::Migration[7.1]
  def change
    change_column :cart_items, :user_id, :bigint, null: true
  end
end

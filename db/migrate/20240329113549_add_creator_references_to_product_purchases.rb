class AddCreatorReferencesToProductPurchases < ActiveRecord::Migration[7.1]
  def change
    add_reference :product_purchases, :creator, null: false, foreign_key: { to_table: :users }
  end
end

class ChangeTableNameToSales < ActiveRecord::Migration[7.1]
  def change
    rename_table :product_purchases, :sales
  end
end

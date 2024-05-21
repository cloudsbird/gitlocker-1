class AddPendingToSales < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :pending, :boolean, default: true, null: false
  end
end

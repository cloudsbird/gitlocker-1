class AddRefundToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :refund, :boolean
  end
end

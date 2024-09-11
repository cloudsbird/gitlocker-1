class AddColumnRefundIdToPurchase < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :refund_id, :string 
  end
end

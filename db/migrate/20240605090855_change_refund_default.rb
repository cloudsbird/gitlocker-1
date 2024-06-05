class ChangeRefundDefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default :purchases, :refund, from: nil, to: false
  end
end

class AddPaymentReferenceToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_reference :purchases, :payment, null: true, foreign_key: true
  end
end

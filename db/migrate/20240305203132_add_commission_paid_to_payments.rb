class AddCommissionPaidToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :commission_paid, :boolean, default: false, null: false
  end
end

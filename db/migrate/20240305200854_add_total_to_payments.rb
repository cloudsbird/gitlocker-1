class AddTotalToPayments < ActiveRecord::Migration[7.1]
  def change
    add_monetize :payments, :total
  end
end

class AddStripeTransactionScreenshotToRefunds < ActiveRecord::Migration[7.1]
  def change
    add_column :refunds, :stripe_transaction_screenshot, :string
  end
end

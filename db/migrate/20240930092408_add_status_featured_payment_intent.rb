class AddStatusFeaturedPaymentIntent < ActiveRecord::Migration[7.1]
  def change
    add_column :featured_payment_intents, :status, :string, default: "unpaid"
  end
end

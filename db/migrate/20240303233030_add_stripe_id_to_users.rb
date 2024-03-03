class AddStripeIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :stripe_id, :string
  end
end

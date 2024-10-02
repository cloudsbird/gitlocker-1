class AddSessionIdToFeaturedPayementIntent < ActiveRecord::Migration[7.1]
  def change
    add_column :featured_payment_intents, :session_id, :string
  end
end

class CreateFeaturedPaymentIntents < ActiveRecord::Migration[7.1]
  def change
    create_table :featured_payment_intents do |t|
      t.string :intent_id
      t.json :intent_object
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end

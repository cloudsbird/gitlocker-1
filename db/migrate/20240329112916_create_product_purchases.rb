class CreateProductPurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :product_purchases do |t|
      t.references :product, null: false, foreign_key: true
      t.references :purchase, null: false, foreign_key: true

      t.timestamps
    end
  end
end

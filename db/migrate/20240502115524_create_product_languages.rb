class CreateProductLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :product_languages do |t|
      t.references :product, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end

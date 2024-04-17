class AddActiveToProductCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :product_categories, :active, :boolean, default: false, null: false
  end
end

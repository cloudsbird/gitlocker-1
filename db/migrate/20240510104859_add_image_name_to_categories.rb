class AddImageNameToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :image_name, :string
  end
end

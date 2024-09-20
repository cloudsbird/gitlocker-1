class AddDirectoryTreeToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :directory_tree, :text
  end
end

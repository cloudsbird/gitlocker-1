class AddDownloadPathToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :download_path, :string
  end
end

class AddImageNameToLanguages < ActiveRecord::Migration[7.1]
  def change
    add_column :languages, :image_name, :string
  end
end

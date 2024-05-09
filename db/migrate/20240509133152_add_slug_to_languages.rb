class AddSlugToLanguages < ActiveRecord::Migration[7.1]
  def change
    add_column :languages, :slug, :string
    add_index :languages, :slug
  end
end

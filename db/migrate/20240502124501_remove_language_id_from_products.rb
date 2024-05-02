class RemoveLanguageIdFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :language_id, :integer
  end
end

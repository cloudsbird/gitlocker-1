class AddLanguageReferenceToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :language, null: false, foreign_key: true
  end
end

class AddForeignKeyToRefunds < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :refunds, :products
    add_foreign_key :refunds, :products, on_delete: :cascade
  end
end

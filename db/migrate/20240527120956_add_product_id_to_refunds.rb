class AddProductIdToRefunds < ActiveRecord::Migration[7.1]
  def change
    add_reference :refunds, :product, null: false, foreign_key: true
  end
end

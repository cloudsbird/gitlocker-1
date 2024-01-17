class AddPriceToProducts < ActiveRecord::Migration[7.1]
  def change
    add_monetize :products, :price
  end
end

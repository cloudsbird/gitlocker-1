class AddPriceToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_monetize :purchases, :price
  end
end

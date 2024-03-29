class RemoveProductsFromSales < ActiveRecord::Migration[7.1]
  def change
    remove_reference :sales, :product
  end
end

class RemoveReferencesInSales < ActiveRecord::Migration[7.1]
  def change
    remove_reference :sales, :creator
  end
end

class AddInstructionsRequirementsFeaturesToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :features, :text
    add_column :products, :instructions, :text
    add_column :products, :requirements, :text
  end
end

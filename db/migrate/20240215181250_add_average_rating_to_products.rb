class AddAverageRatingToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :average_rating, :float, default: 0, null: false
  end
end

class AddUniquenessIndexToReviews < ActiveRecord::Migration[7.1]
  def change
    add_index :reviews, [:product_id, :user_id], unique: true
  end
end

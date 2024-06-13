class CreateJoinTableUserCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :user_categories do |t|
      t.bigint :user_id, null: false
      t.bigint :category_id, null: false
      t.boolean :active, default: false, null: false
      t.timestamps null: false
    end

    add_index :user_categories, :category_id
    add_index :user_categories, [:user_id, :category_id], unique: true
    add_index :user_categories, :user_id
  end
end

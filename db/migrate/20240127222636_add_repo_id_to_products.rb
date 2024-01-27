class AddRepoIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :repo_id, :bigint
    add_index :products, :repo_id, unique: true
  end
end

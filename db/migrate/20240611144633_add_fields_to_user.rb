class AddFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :fullname, :string
    add_column :users, :bio, :text
    add_column :users, :company, :string
    add_column :users, :location, :string
  end
end

class AddGithubColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :token, :string
    add_column :users, :username, :string
    add_column :users, :name, :string
  end
end

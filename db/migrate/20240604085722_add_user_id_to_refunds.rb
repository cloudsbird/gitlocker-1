class AddUserIdToRefunds < ActiveRecord::Migration[7.1]
  def change
    add_column :refunds, :user_id, :integer
  end
end

class AddStatusToRefunds < ActiveRecord::Migration[7.1]
  def change
    add_column :refunds, :status, :string, default: 'pending'
  end
end

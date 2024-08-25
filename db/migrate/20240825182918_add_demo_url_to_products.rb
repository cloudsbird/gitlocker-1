class AddDemoUrlToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :demo_url, :string
  end
end

class CreateRefunds < ActiveRecord::Migration[7.1]
  def change
    create_table :refunds do |t|
      t.text :description

      t.timestamps
    end
  end
end

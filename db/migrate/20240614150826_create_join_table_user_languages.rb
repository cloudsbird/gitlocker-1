class CreateJoinTableUserLanguages < ActiveRecord::Migration[7.1]
  def change
    create_table :user_languages do |t|
      t.bigint :user_id, null: false
      t.bigint :language_id, null: false
      t.boolean :active, default: false, null: false
      t.timestamps null: false
    end

    add_index :user_languages, :language_id
    add_index :user_languages, [:user_id, :language_id], unique: true
    add_index :user_languages, :user_id
  end
end

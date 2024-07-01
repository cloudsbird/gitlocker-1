# db/migrate/YYYYMMDDHHMMSS_create_notifications.rb
class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :recipient, polymorphic: true, null: false
      t.string :type
      t.jsonb :params
      t.datetime :read_at
      t.timestamps
    end

    add_index :notifications, [:recipient_id, :recipient_type]
    add_index :notifications, :read_at
  end
end

class CreateSubscribedUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :subscribed_users do |t|
      t.string :email

      t.timestamps
    end
  end
end

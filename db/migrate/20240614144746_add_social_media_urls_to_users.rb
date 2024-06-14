class AddSocialMediaUrlsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :facebook_url, :string
    add_column :users, :instagram_url, :string
    add_column :users, :linkedin_url, :string
    add_column :users, :youtube_url, :string
  end
end

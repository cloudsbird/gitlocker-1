class AddPreviewVideoUrlToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :preview_video_url, :string
  end
end

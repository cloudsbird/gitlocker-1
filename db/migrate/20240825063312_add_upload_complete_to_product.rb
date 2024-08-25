class AddUploadCompleteToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :upload_complete, :boolean, null: false, default: false

    # Update existing records based on the created_at timestamp    
    Product.unscoped.where("created_at < ?", Time.current).update_all(upload_complete: true) rescue nil
  end
end
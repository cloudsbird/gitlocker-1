class ImageNameNullNotFalseLanguages < ActiveRecord::Migration[7.1]
  def change
    change_column_null :languages, :image_name, false
  end
end

class NameNullNotFalseLanguages < ActiveRecord::Migration[7.1]
  def change
    change_column_null :languages, :name, false
  end
end

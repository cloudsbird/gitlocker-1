class ProductLanguage < ApplicationRecord
  belongs_to :product
  belongs_to :language
end

class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  monetize :price_cents

  belongs_to :user

  has_many_attached :covers

  validates :name, presence: true
  validates :url, presence: true, uniqueness: { scope: :name }
end

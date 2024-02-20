class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  monetize :price_cents

  belongs_to :user
  belongs_to :language

  has_many :reviews, dependent: :destroy

  has_many_attached :covers

  validates :name, presence: true
  validates :url, presence: true, uniqueness: { scope: :name }
end

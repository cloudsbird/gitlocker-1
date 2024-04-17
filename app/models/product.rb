class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  monetize :price_cents

  belongs_to :user
  belongs_to :language

  has_many :reviews, dependent: :destroy
  has_many :purchases

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :active_categories, -> {
    where("product_categories.active = ?", true)
  }, through: :product_categories, source: :category

  has_many_attached :covers

  validates :name, presence: true
  validates :url, presence: true, uniqueness: { scope: :name }

  accepts_nested_attributes_for :product_categories

  include PgSearch::Model

  multisearchable against: [:name, :language_name, :category_names, :description],
                  if: :published?

  def language_name
    language.name
  end

  def category_names
    active_categories.pluck(:name).join(" ")
  end

  after_commit :seed_categories, on: :create
  def seed_categories
    product_categories_to_seed = Category.all.map do |category|
      ProductCategory.new(product: self, category: category)
    end
    ProductCategory.import(product_categories_to_seed)
  end
end

class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  monetize :price_cents

  belongs_to :user

  has_many :reviews, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_one_attached :folder, dependent: :destroy
  has_one_attached :video_file, dependent: :destroy
  has_one :refund, dependent: :destroy

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :active_categories, -> {
    where("product_categories.active = ?", true)
  }, through: :product_categories, source: :category

  has_many :product_languages, dependent: :destroy
  has_many :languages, through: :product_languages
  has_many :active_languages, -> { where("product_languages.active = ?", true) }, through: :product_languages, source: :language

  has_many_attached :covers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :name, presence: true, uniqueness: true, on: :create
  # validates :url, presence: true, uniqueness: { scope: :name }

  accepts_nested_attributes_for :product_categories
  scope :exclude_purchased, ->(user) { 
    where.not(id: user&.purchases&.pluck(:product_id))
  }

  include PgSearch::Model
  pg_search_scope :search,
                  against: [:name],
                  using: {
                    tsearch: { prefix: true }
                  }

  multisearchable against: [:name, :category_names, :description],associated_against: {
                  languages: [:name]
                  },
                  if: :published?

  DEFAULT_PRODUCT_IMAGES = [
    "featured/10-mini-JS-projects-for-beginners.png",
    "featured/a-bootstrap-html-template.png",
    "featured/backend-with-django.png",
    "featured/bug-finder.png",
    "featured/flask-react-app.png",
    "popular/open-source-DocuSign-alternative.png",
    "popular/pytides.png",
    "popular/redux-toolkit.png",
    "popular/sudoku-solver.png",
    "popular/typescript-complete-course.png"
  ]

  scope :recent, -> { order(created_at: :desc) }
  scope :published, -> { where(published: true) }

  def language_name
    languages.pluck(:name).join(", ")
  end

  def category_names
    active_categories.pluck(:name).join(" ")
  end

  # after_commit :seed_categories, on: :create
  def seed_categories
    product_categories_to_seed = Category.all.map do |category|
      ProductCategory.new(product: self, category: category)
    end
    ProductCategory.import(product_categories_to_seed)
  end

  def normalize_friendly_id(text)
    super.gsub(/\d+/, '')
  end

  def self.ransackable_attributes(auth_object = nil)
    ["active", "average_rating", "created_at", "description", "download_path", "featured", "id", "id_value", "name", "preview_video_url", "price_cents", "price_currency", "published", "purchases_count", "repo_id", "reviews_count", "slug", "updated_at", "url", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["active_categories", "active_languages", "cart_items", "categories", "covers_attachments", "covers_blobs", "folder_attachment", "folder_blob", "languages", "likes", "pg_search_document", "product_categories", "product_languages", "purchases", "refund", "reviews", "user", "video_file_attachment", "video_file_blob"]
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable,:confirmable, omniauth_providers: [:github]

  enum :registration_status, {
    registration_pending: 0,
    registration_completed: 1
  }

  enum state: { buyer: 0, seller: 1 }
  extend FriendlyId
  friendly_id :email_stripped, use: :slugged, slug_column: :username

  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :products_in_cart, through: :cart_items, source: :product
  has_many :purchases, dependent: :destroy
  has_many :purchased_products, through: :purchases, source: :product
  has_many :payments, dependent: :destroy
  has_many :refunds, dependent: :destroy
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories
  has_many :active_categories, -> {
    where("user_categories.active = ?", true)
  }, through: :user_categories, source: :category
  has_many :user_languages, dependent: :destroy
  has_many :languages, through: :user_languages
  has_many :active_languages, -> {
    where("user_languages.active = ?", true)
  }, through: :user_languages, source: :language
  has_many :sales, through: :products, source: :purchases
  has_one :account

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  has_one_attached :profile_picture

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  scope :sellers, -> { where(seller: true) }

  include PgSearch::Model
  pg_search_scope :search,
                  against: [:name, :email, :username],
                  using: {
                    tsearch: { prefix: true }
                  }

  def self.from_omniauth(access_token)
    token    = access_token.credentials.token
    email    = access_token.info.email
    name     = access_token.info.name
    username = access_token.info.nickname
    user     = User.find_by(email: email)

    if user
      user.update(token: token, name: name, username: username)
    else
      user = User.create(
        # You can record new values based on the model and github api e.g -> name: data["name"],
        email: email,
        password: Devise.friendly_token[0, 20],
        token: token,
        name: name,
        username: username
      )
    end

    user
  end

  def clone_repositories(git_url)
    # Temporary method to have a note of how to clone repositories
    "git clone https://oauth2:#{token}@github.com/#{username}/{repository_name}"
  end

  def email_stripped
    email.split("@").first
  end

  def total_sales_amount_in_dollars
    total_sale_value = sales.where(pending: true, refund: false).sum(:price_cents)
    total_sale_value *= 0.9 
    total_sale_value /= 100.0
  end
  
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  enum :registration_status, {
    registration_pending: 0,
    registration_completed: 1
  }

  extend FriendlyId
  friendly_id :email_stripped, use: :slugged, slug_column: :username

  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :products_in_cart, through: :cart_items, source: :product
  has_many :purchases, dependent: :destroy
  has_many :purchased_products, through: :purchases, source: :product
  has_many :payments, dependent: :destroy
  has_many :sales

  has_one_attached :profile_picture

  validates :username, presence: true, uniqueness: { case_sensitive: false }

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
end

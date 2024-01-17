class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  has_many :products, dependent: :destroy

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
end

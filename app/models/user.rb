class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  def self.from_omniauth(access_token)
  data = access_token.info
  user = User.where(email: data['email']).first

    # A User will be created if they don´t exist
    unless user
        user = User.create(
            # You can record new values based on the model and github api e.g -> name: data['name'],
            email: data['email'],
            password: Devise.friendly_token[0,20]
        )
    end
    user
  end
end
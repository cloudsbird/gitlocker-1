class SubscribedUser < ApplicationRecord
  validates :email, presence: true
end

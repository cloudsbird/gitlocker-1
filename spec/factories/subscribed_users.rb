FactoryBot.define do
  factory :subscribed_user do
    sequence(:email) { |n| "subscribed#{n}@example.com"}
  end
end

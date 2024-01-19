FactoryBot.define do
  factory :product do
    user
    sequence(:name) { |n| "product-name-#{n}" }
    sequence(:url) { |n| "https://www.github.com/#{n}" }
  end
end

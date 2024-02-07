FactoryBot.define do
  factory :review do
    product { nil }
    user { nil }
    rating { 1 }
    body { "MyText" }
  end
end

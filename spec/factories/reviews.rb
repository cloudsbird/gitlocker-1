FactoryBot.define do
  factory :review do
    product
    user
    rating { 1 }
    body { "MyText" }
  end
end

FactoryBot.define do
  factory :language do
    name { Faker::ProgrammingLanguage.name }
    image_name { "language_name.png" }
  end
end

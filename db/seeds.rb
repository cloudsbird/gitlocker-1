chris = User.find_or_create_by(
  email: "chris@typefast.co",
  username: "chrisjeon",
  name: "Chris Jeon",
  registration_status: "registration_completed",
  synced: true
) do |user|
  user.password = "password"
end

chris.save

cody = User.find_or_create_by(
  email: "codyrutscher@gmail.com",
  username: "codyrutscher",
  name: "Cody Rutscher",
  registration_status: "registration_completed",
  synced: true
) do |user|
  user.password = "password"
end

cody.save

languages = Language::NAMES.keys.map do |language_name|
  Language.new(name: language_name, image_name: Language::NAMES[language_name])
end

Language.import(
  languages,
  on_duplicate_key_update: {
    conflict_target: [:name],
    columns: [:image_name]
  }
)

categories = Category::NAMES.keys.map do |category_name|
  Category.new(name: category_name, image_name: Category::NAMES[category_name])
end

Category.import(
  categories,
  on_duplicate_key_update: {
    conflict_target: [:name],
    columns: [:image_name]
  }
)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
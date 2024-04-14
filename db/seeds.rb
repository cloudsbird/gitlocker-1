chris = User.create(
  email: "chris@typefast.co",
  username: "chrisjeon",
  name: "Chris Jeon",
  password: "password",
  registration_status: "registration_completed",
  synced: true
)

cody = User.create(
  email: "codyrutscher@gmail.com",
  username: "codyrutscher",
  name: "Cody Rutscher",
  password: "password",
  registration_status: "registration_completed",
  synced: true
)

3.times do
  User.create(
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    name: Faker::Name.name,
    password: "password",
    registration_status: "registration_completed",
    synced: true
  )
end

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

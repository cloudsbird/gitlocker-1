chris = User.create(
  email: "chris@typefast.co",
  username: "chrisjeon",
  name: "Chris Jeon",
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

User.create!(
  name: "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  birthday: "1999/08/06",
  gender: "Male",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

19.times do |n|
  name = Faker::Name.name
  email = "admin-#{n+1}@railstutorial.org"
  password = "123456"
  birthday = "1999/08/06"
  gender = "Male"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    birthday: birthday,
    gender: gender,
    activated: true,
    activated_at: Time.zone.now
  )
end

users = User.order(:created_at).take(6)
30.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

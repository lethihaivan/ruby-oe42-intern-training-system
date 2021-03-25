# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Example User",
  email: "haivan17tclc2@gmail.com",
  password: "haivan",
  password_confirmation: "haivan",
  role: 1,
  gender: 1,
  date_of_birth: Time.zone.now,
  start_date: Time.zone.now,
  end_time: Time.zone.now ,
  deleted: false )

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  role = Faker::Number.within(range: 0..2)
  gender = Faker::Number.within(range: 0..1)
  date_of_birth = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  start_date = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  end_time = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: role,
    gender: gender,
    date_of_birth: date_of_birth,
    start_date: start_date,
    end_time:end_time,
    deleted: false )
end

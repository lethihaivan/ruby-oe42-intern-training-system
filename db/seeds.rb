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

Course.create!(name: "Ruby on rails OE42",
  time: 40,
  status: 0)

Course.create!(name: "Java OE42",
  time: 20,
  status: 2)

Course.create!(name: "Front_end OE42",
  time: 50,
  status: 2)

Course.create!(name: "QA OE42",
  time: 40,
  status: 2)

Course.create!(name: "PHP OE42",
  time: 40,
  status: 2)
Course.create!(name: "Dotnet OE42",
  time: 40,
  status: 2)
Course.create!(name: "NodeJs OE42",
  time: 40,
  status: 2)

Subject.create!(name: "Rails",
  description: "Rails tutorial",
  time: 10,
  optional: true,
  order: 1,
  course_id: 1
)

Subject.create!(name: "Git",
  description: "Git basic and advance",
  time: 10,
  optional: true,
  order: 2,
  course_id: 2)

Subject.create!(name: "Mysql",
  description: "MySql basic",
  time: 10,
  optional: false,
  order: 3,
  course_id: 1)

Subject.create!(name: "Ruby",
  description: "Ruby programing language",
  time: 8,
  optional: true,
  order: 4,
  course_id: 4)

Subject.create!(name: "PHP",
  description: "PHP programing language",
  time: 6,
  optional: true,
  order: 5,
  course_id: 3)

Subject.create!(name: "Laravel",
  description: "Laravel quicktasks",
  time: 4,
  optional: false,
  order: 6,
  course_id: 2)

Subject.create!(name: "Scrum",
  description: "Basic Scrum",
  time: 2,
  optional: true,
  order: 7,
  course_id: 4)

99.times do |n|
  name = Faker::Lorem.sentence(word_count: 5)
  subject_id = Faker::Number.within(range: 1..6)
  Task.create!(name: name,
  subject_id: subject_id)
end

99.times do |n|
  course_id = Faker::Number.within(range: 1..6)
  user_id = Faker::Number.within(range: 1..99)
  active = true
  start_date = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  end_date = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  UserCourse.create!(
    active: active,
    course_id: course_id,
    user_id: user_id,
    start_date: start_date,
    end_date: end_date)
end

99.times do |n|
  subject_id = Faker::Number.within(range: 1..6)
  user_course_id = Faker::Number.within(range: 1..6)
  status = Faker::Number.within(range: 0..1)
  start_date = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  end_date = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  UserSubject.create!(
    status: status,
    subject_id:subject_id,
    user_course_id: user_course_id,
    start_date: start_date,
    end_date: end_date)
end

99.times do |n|
  task_id = Faker::Number.within(range: 1..99)
  user_subject_id = Faker::Number.within(range: 1..99)
  status = Faker::Number.within(range: 0..1)
  UserTask.create!(task_id: task_id,
    user_subject_id: user_subject_id,
    status: status)
end


40.times do |n|
  course_id = Course.all.pluck(:id).sample
  subject_id = Subject.all.pluck(:id).sample
  status = CourseSubject.statuses.keys.sample
  CourseSubject.create!(course_id: course_id,
    subject_id: subject_id,
    status: status)
end

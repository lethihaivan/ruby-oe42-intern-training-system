# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

99.times do |n|
  name = Faker::Lorem.sentence(word_count: 5)
  subject_id = Subject.pluck(:id).sample
  Task.create!(name: name,
  subject_id: subject_id)
end

99.times do |n|
  course_id = Course.pluck(:id).sample
  user_id = User.pluck(:id).sample
  status = UserCourse.statuses.keys.sample
  UserCourse.create!(
    status: status,
    course_id: course_id,
    user_id: user_id)
end

40.times do |n|
  course_id = Course.pluck(:id).sample
  subject_id = Subject.pluck(:id).sample
  status = CourseSubject.statuses.keys.sample
  start_date = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  end_date = Faker::Time.between(from: DateTime.now + 24, to: DateTime.now)
  CourseSubject.create!(course_id: course_id,
    subject_id: subject_id,
    status: status,
    start_date: start_date,
    end_date: end_date)
end

99.times do |n|
  course_subject_id = CourseSubject.pluck(:id).sample
  user_id = User.pluck(:id).sample
  status = UserSubject.statuses.keys.sample
  start_date = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  end_date = Faker::Time.between(from: DateTime.now + 24, to: DateTime.now)
  UserSubject.create!(
    status: status,
    course_subject_id:course_subject_id,
    user_id: user_id,
    start_date: start_date,
    end_date: end_date)
end

50.times do |n|
  task_id = Task.pluck(:id).sample
  user_subject_id = UserSubject.pluck(:id).sample
  status = UserTask.statuses.keys.sample
  receive_at = Faker::Time.between(from: DateTime.now - 24, to: DateTime.now)
  finish_at = Faker::Time.between(from: DateTime.now + 24, to: DateTime.now)
  UserTask.create!(task_id: task_id,
    user_subject_id: user_subject_id,
    status: status,
    receive_at: receive_at,
    finish_at: finish_at)
end

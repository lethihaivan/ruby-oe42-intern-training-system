require "faker"
FactoryBot.define do
  factory :course do |c|
    c.name {Faker::Name.name}
    c.time {Faker::Number.within(range: 1..50)}
    c.start_date {Time.zone.now}
    c.end_date {Time.zone.now + 7200}
  end
end

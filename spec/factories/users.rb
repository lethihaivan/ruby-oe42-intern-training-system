FactoryBot.define do
  factory :user do |c|
    c.name {"test@test.com"}
    c.email {"test@test.com"}
    c.password {"password"}
    c.password_confirmation {"password"}
    c.role {User.roles[:supervisor]}
  end

  factory :not_supervisor, class: User do |c|
    c.name {"notadmin@test.com"}
    c.email {"notadmin@test.com"}
    c.password {"password"}
    c.password_confirmation {"password"}
    c.role {User.roles[:trainee]}
  end

  factory :trainer, class: User do |c|
    c.name {"trainer@test.com"}
    c.email {"trainer@test.com"}
    c.password {"password"}
    c.password_confirmation {"password"}
    c.role {User.roles[:supervisor]}
  end

  factory :trainee, class: User do |c|
    c.name {"trainee"}
    c.email {"trainee@test.com"}
    c.password {"password"}
    c.password_confirmation {"password"}
    c.role {User.roles[:trainee]}
  end
end

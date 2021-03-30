class UserSubject < ApplicationRecord
  belongs_to :user_course
  belongs_to :subject
  enum status: {joined: 0, active: 1, finished: 2}
end

class UserSubject < ApplicationRecord
  belongs_to :user_course
  belongs_to :subject
end

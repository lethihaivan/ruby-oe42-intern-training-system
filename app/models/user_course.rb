class UserCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user
  enum status: {joined: 0, active: 1, finished: 2}
  delegate :name, :start_date, :end_date, to: :course, allow_nil: true
end

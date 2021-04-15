class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  has_many :user_subjects, dependent: :destroy
  enum status: {joined: 0, active: 1, finished: 2}
  delegate :name, :time, to: :subject, allow_nil: true
end

class Course < ApplicationRecord
  enum stauts: {openning: 0, opened: 1}
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  accepts_nested_attributes_for :subjects
  validates :name, presence: true,
    length: {minimum: Settings.course.name_min_length}
end

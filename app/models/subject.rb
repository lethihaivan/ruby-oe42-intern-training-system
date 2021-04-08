class Subject < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  scope :ordered_by_name, ->{order :name}
end

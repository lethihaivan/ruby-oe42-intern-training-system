class Course < ApplicationRecord
  enum status: {open: 0, start: 1, finished: 2}
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :user_courses, dependent: :destroy
  has_many :trainees, through: :user_courses, source: :user

  accepts_nested_attributes_for :subjects
  validates :name, presence: true,
    length: {minimum: Settings.course.name_min_length}

  scope :create_newest, ->{order created_at: :desc}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_time_is_valid

  def end_time_is_valid
    return if start_date.blank? || end_date.blank?

    error_msg = I18n.t "courses.supervisor.index.date_validate"
    errors.add(:end_date, error_msg) if end_date < start_date
  end
end

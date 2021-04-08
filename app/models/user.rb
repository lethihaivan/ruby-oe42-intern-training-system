class User < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
  has_many :user_subjects, dependent: :destroy
  has_many :subjects, through: :user_subjects
  enum role: {admin: 0, supervisor: 1, trainee: 2}
  enum gender: {male: 0, female: 1}
  validates :name, presence: true,
   length: {maximum: Settings.user.name.max_length}
  validates :email, presence: true,
   length: {maximum: Settings.user.email.max_length},
   format: {with: Settings.user.email.regex}
  validates :password, presence: true,
   length: {minimum: Settings.user.password.min_length}
  before_save ->{email.downcase!}
  has_secure_password
  scope :ordered_by_name, ->{order :name}
  scope :by_ids, ->(ids){where id: ids}
  scope :not_exit_on_course, (lambda do |course_id|
    where("id not in (?)", UserCourse.select("user_id")
   .where(course_id: course_id))
  end)
  def self.digest string
    cost =  if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else
              BCrypt::Engine.cost
            end
    BCrypt::Password.create string, cost: cost
  end
end

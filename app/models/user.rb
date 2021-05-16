class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
  has_many :user_subjects, dependent: :destroy
  enum role: {admin: 0, supervisor: 1, trainee: 2}
  enum gender: {male: 0, female: 1}
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

class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :course_subject
  has_many :user_tasks, dependent: :destroy
  enum status: {joined: 0, active: 1, finished: 2}
  scope :by_user, ->(user_id){where("user_id = ?", user_id)}
end

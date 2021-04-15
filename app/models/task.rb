class Task < ApplicationRecord
  belongs_to :subject
  has_many :user_tasks, dependent: :destroy
  scope :newest, ->{order created_at: :desc}
  scope :of_subjects, ->(ids){where subject_id: ids}
  scope :not_exit_in_user_task, (lambda do |user_subject|
    where("id not in (?)", UserTask.task_in_user_tasks(user_subject))
  end)
end

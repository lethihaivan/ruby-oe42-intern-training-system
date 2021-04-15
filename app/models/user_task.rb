class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user_subject
  before_create :set_receive_at
  enum status: {inprogess: 0, finished: 1, expired: 2}
  scope :task_in_user_tasks, (lambda do |user_subject|
    where(user_subject: user_subject).select("task_id")
  end)
  private

  def set_receive_at
    self.receive_at = Time.current
  end
end

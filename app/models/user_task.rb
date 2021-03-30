class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user_subject
  enum status: {inprogess: 0, finished: 1, expired: 2}
end

class AddColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :user_tasks, :receive_at, :datetime
    add_column :user_tasks, :finish_at, :datetime
  end
end

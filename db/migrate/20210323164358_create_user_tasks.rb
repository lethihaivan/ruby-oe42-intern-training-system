class CreateUserTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :user_tasks do |t|
      t.integer :status
      t.references :task, null: false
      t.references :user_subject, null: false

      t.timestamps
    end
    add_foreign_key :user_tasks, :tasks, column: :task_id
    add_foreign_key :user_tasks, :user_subjects, column: :user_subject_id
  end
end

class CreateUserSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :user_subjects do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status, default: 0
      t.references :user_course, null: false
      t.references :subject, null: false

      t.timestamps
    end
    add_foreign_key :user_subjects, :user_courses, column: :user_course_id
    add_foreign_key :user_subjects, :subjects, column: :subject_id
  end
end

class CreateUserCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :user_courses do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :active
      t.references :course, null: false
      t.references :user, null: false
      t.timestamps
    end
    add_foreign_key :user_courses, :courses, column: :course_id
    add_foreign_key :user_courses, :users, column: :user_id
  end
end

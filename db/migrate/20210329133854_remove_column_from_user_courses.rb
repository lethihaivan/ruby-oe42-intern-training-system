class RemoveColumnFromUserCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_courses, :start_date
    remove_column :user_courses, :end_date
  end
end

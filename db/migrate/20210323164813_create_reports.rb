class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.datetime :for_date
      t.text :doing_today_content
      t.text :issues
      t.text :will_do_tomorrow
      t.references :user, null: false
      t.references :user_course, null: false

      t.timestamps
    end
    add_foreign_key :reports, :user_courses, column: :user_course_id
    add_foreign_key :reports, :users, column: :user_id
  end
end

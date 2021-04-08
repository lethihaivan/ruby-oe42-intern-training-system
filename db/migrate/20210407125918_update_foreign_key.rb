class UpdateForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_reference :user_subjects, :subject, index: true, foreign_key: true
    remove_reference :user_subjects, :user_course, index: true, foreign_key: true

    add_reference :user_subjects, :course_subject, null: false, foreign_key: true
    add_reference :user_subjects, :user, null: false, foreign_key: true
  end
end

class ChangeDataTypeForUserSubject < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_courses, :active
    add_column :user_courses, :status, :integer 
  end
end

class AddColumnFromCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :start_date , :datetime
    add_column :courses, :end_date, :datetime
    add_column :courses, :image, :string
  end
end

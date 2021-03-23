class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :time
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

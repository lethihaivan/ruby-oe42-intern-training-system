class CreateSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :time
      t.text :description
      t.boolean :optional
      t.integer :order

      t.timestamps
    end
  end
end

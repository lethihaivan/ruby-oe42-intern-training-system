class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.integer :role
      t.integer :gender
      t.datetime :date_of_birth
      t.datetime :start_date
      t.datetime :end_time
      t.boolean :delete

      t.timestamps
    end
  end
end

class RenameDeleteToDeletedInUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :delete, :deleted
  end
end

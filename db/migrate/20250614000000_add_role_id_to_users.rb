class AddRoleIdToUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :role, :integer if column_exists?(:users, :role)
    add_reference :users, :role, foreign_key: true
  end
end 
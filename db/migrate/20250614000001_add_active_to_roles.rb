class AddActiveToRoles < ActiveRecord::Migration[8.0]
  def change
    add_column :roles, :active, :boolean, default: true, null: false
  end
end 
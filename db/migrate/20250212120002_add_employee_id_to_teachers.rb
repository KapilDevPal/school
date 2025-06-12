class AddEmployeeIdToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :employee_id, :string
  end
end 
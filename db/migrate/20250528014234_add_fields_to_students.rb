class AddFieldsToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    add_column :students, :admission_number, :string
    add_column :students, :class_section, :string
    add_column :students, :date_of_birth, :date
  end
end

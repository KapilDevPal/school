class AddParentFieldsToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :parent_name, :string
    add_column :students, :parent_phone, :string
  end
end 
class AddRollNumberToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :roll_number, :string
    add_index :students, [:roll_number, :school_class_id], unique: true
  end
end 
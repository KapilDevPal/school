class AddGenderToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :gender, :string
  end
end 
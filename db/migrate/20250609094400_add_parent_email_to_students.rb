class AddParentEmailToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :parent_email, :string
  end
end 
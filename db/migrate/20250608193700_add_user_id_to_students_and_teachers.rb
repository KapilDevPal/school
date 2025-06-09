class AddUserIdToStudentsAndTeachers < ActiveRecord::Migration[8.0]
  def change
    add_reference :students_and_teachers, :user, null: false, foreign_key: true
  end
end

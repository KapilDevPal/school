class AddUserIdToStudentsAndTeachers < ActiveRecord::Migration[8.0]
  def change
    add_reference :students, :user, null: false, foreign_key: true
    add_reference :teachers, :user, null: false, foreign_key: true
  end
end

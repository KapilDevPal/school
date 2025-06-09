class AddSchoolClassIdToStudents < ActiveRecord::Migration[7.1]
  def change
    add_reference :students, :school_class, null: true, foreign_key: true
  end
end

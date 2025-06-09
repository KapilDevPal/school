class CreateStudentClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :student_classes do |t|
      t.references :student, null: false, foreign_key: true
      t.references :school_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end

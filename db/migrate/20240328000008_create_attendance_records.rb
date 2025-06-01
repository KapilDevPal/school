class CreateAttendanceRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :attendance_records do |t|
      t.date :date, null: false
      t.string :status, null: false
      t.text :remarks
      t.references :school_class, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end

    add_index :attendance_records, [:school_class_id, :student_id, :date], unique: true, name: 'index_attendance_records_on_class_student_date'
  end
end 
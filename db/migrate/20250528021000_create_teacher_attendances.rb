class CreateTeacherAttendances < ActiveRecord::Migration[8.0]
  def change
    create_table :teacher_attendances do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.date :date, null: false
      t.string :status, null: false
      t.text :remarks

      t.timestamps
    end
    add_index :teacher_attendances, [:teacher_id, :date], unique: true
  end
end 
class CreateExamResults < ActiveRecord::Migration[8.0]
  def change
    create_table :exam_results do |t|
      t.references :student, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.decimal :marks_obtained, precision: 5, scale: 2, null: false
      t.decimal :total_marks, precision: 5, scale: 2, null: false
      t.text :remarks

      t.timestamps
    end

    add_index :exam_results, [:student_id, :exam_id, :subject_id], unique: true
  end
end 
class CreateExams < ActiveRecord::Migration[8.0]
  def change
    create_table :exams do |t|
      t.references :school, null: false, foreign_key: true
      t.references :school_class, null: false, foreign_key: true
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.text :description

      t.timestamps
    end
  end
end 
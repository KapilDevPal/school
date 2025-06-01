class CreateTimetables < ActiveRecord::Migration[8.0]
  def change
    create_table :timetables do |t|
      t.string :day_of_week, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.string :room_number, null: false
      t.references :school, null: false, foreign_key: true
      t.references :school_class, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end

    add_index :timetables, [:school_class_id, :day_of_week, :start_time, :end_time], unique: true, name: 'index_timetables_on_class_and_time'
  end
end 
class CreateTeacherClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :teacher_classes do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :school_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end

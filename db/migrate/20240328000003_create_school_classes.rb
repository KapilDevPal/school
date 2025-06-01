class CreateSchoolClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :school_classes do |t|
      t.string :name, null: false
      t.string :grade, null: false
      t.string :section, null: false
      t.string :room_number, null: false
      t.integer :capacity, null: false
      t.references :school, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end

    add_index :school_classes, [:name, :school_id], unique: true
  end
end 
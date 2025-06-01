class CreateSalaryStructures < ActiveRecord::Migration[8.0]
  def change
    create_table :salary_structures do |t|
      t.references :school, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.decimal :basic_salary, precision: 10, scale: 2, null: false
      t.decimal :house_rent_allowance, precision: 10, scale: 2
      t.decimal :dearness_allowance, precision: 10, scale: 2
      t.decimal :travel_allowance, precision: 10, scale: 2
      t.decimal :medical_allowance, precision: 10, scale: 2
      t.text :notes

      t.timestamps
    end

    add_index :salary_structures, [:school_id, :teacher_id], unique: true
  end
end 
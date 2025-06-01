class CreatePayslips < ActiveRecord::Migration[8.0]
  def change
    create_table :payslips do |t|
      t.references :school, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.references :salary_structure, null: false, foreign_key: true
      t.integer :month, null: false
      t.integer :year, null: false
      t.decimal :basic_salary, precision: 10, scale: 2, null: false
      t.decimal :house_rent_allowance, precision: 10, scale: 2
      t.decimal :dearness_allowance, precision: 10, scale: 2
      t.decimal :travel_allowance, precision: 10, scale: 2
      t.decimal :medical_allowance, precision: 10, scale: 2
      t.decimal :total_salary, precision: 10, scale: 2, null: false
      t.string :status, default: 'pending', null: false
      t.date :paid_at
      t.text :notes

      t.timestamps
    end

    add_index :payslips, [:school_id, :teacher_id, :month, :year], unique: true, name: 'index_payslips_on_school_teacher_month_year'
  end
end 
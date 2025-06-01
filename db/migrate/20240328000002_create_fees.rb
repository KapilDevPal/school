class CreateFees < ActiveRecord::Migration[8.0]
  def change
    create_table :fees do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.date :due_date, null: false
      t.string :status, null: false
      t.date :payment_date
      t.string :payment_method
      t.references :student, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end 
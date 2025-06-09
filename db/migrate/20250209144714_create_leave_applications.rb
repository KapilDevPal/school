class CreateLeaveApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :leave_applications do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.text :reason, null: false
      t.string :status, default: 'pending'
      t.text :admin_comment

      t.timestamps
    end
  end
end 
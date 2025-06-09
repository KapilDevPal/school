class AddStudentFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :school_class_id, null: false, foreign_key: true
    add_column :users, :admission_number, :string
    add_column :users, :class_section, :string
    add_column :users, :date_of_birth, :date
  end
end

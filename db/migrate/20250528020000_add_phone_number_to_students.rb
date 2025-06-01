class AddPhoneNumberToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :phone_number, :string
  end
end 
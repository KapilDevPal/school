class AddGenderAndAddressToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :gender, :string
    add_column :teachers, :address, :text
  end
end

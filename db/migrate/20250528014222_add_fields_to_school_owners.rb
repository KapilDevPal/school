class AddFieldsToSchoolOwners < ActiveRecord::Migration[8.0]
  def change
    add_column :school_owners, :first_name, :string
    add_column :school_owners, :last_name, :string
  end
end

class RemoveSchoolIdFromSchoolOwners < ActiveRecord::Migration[8.0]
  def change
    remove_reference :school_owners, :school, null: false, foreign_key: true
    add_column :schools, :plan_id, :integer, null: false, default: 1

  end
end

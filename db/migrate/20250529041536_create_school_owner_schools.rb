class CreateSchoolOwnerSchools < ActiveRecord::Migration[8.0]
  def change
    create_table :school_owner_schools do |t|
      t.references :school_owner, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end

    add_index :school_owner_schools, [:school_owner_id, :school_id], unique: true
  end
end

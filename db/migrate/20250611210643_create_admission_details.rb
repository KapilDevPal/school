class CreateAdmissionDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :admission_details do |t|
      t.references :student, null: false, foreign_key: true
      t.string :aadhaar_number
      t.string :ssmid_number
      t.string :scholar_no
      t.string :family_id
      t.string :place_of_birth
      t.string :nationality
      t.string :mother_tongue
      t.string :other_languages
      t.string :category
      t.string :subcategory
      t.string :religion
      t.string :father_name
      t.string :father_mobile
      t.string :father_email
      t.string :father_occupation
      t.integer :father_income
      t.string :mother_name
      t.string :mother_mobile
      t.string :mother_email
      t.string :mother_occupation
      t.integer :mother_income
      t.integer :total_family_income

      t.timestamps
    end
  end
end

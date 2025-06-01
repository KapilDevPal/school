class CreateTeachers < ActiveRecord::Migration[8.0]
  def change
    create_table :teachers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.string :password_digest, null: false
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end

    add_index :teachers, [:email, :school_id], unique: true
  end
end 
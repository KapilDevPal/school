class CreateSubjects < ActiveRecord::Migration[8.0]
  def change
    create_table :subjects do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description, null: false
      t.integer :credits, null: false
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end

    add_index :subjects, [:code, :school_id], unique: true
  end
end 
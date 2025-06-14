class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.json :permissions
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end

    add_index :roles, [:name, :school_id], unique: true
  end
end 
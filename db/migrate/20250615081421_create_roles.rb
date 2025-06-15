class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :users, :role, foreign_key: true
  end
end

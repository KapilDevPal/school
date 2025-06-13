class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.text :permissions
      t.boolean :active
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end

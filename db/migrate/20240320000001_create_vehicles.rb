class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :registration_number, null: false
      t.string :vehicle_type, null: false
      t.integer :capacity, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :vehicles, :registration_number, unique: true
  end
end 
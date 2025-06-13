class CreateTransportVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :transport_vehicles do |t|
      t.references :school, null: false, foreign_key: true
      t.string :name
      t.string :registration_number
      t.string :vehicle_type
      t.integer :capacity
      t.string :status
      t.boolean :active

      t.timestamps
    end
  end
end

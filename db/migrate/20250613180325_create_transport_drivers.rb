class CreateTransportDrivers < ActiveRecord::Migration[8.0]
  def change
    create_table :transport_drivers do |t|
      t.references :school, null: false, foreign_key: true
      t.string :name
      t.string :license_number
      t.string :phone
      t.string :email
      t.string :status
      t.boolean :active

      t.timestamps
    end
  end
end

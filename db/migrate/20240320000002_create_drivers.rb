class CreateDrivers < ActiveRecord::Migration[7.0]
  def change
    create_table :drivers do |t|
      t.string :name, null: false
      t.string :license_number, null: false
      t.string :phone_number, null: false
      t.text :address, null: false
      t.date :license_expiry_date, null: false
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :drivers, :license_number, unique: true
  end
end 
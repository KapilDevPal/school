class CreateTransportRoutes < ActiveRecord::Migration[7.0]
  def change
    create_table :transport_routes do |t|
      t.string :name, null: false
      t.string :start_point, null: false
      t.string :end_point, null: false
      t.references :vehicle, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end 
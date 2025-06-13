class CreateRouteStops < ActiveRecord::Migration[7.0]
  def change
    create_table :route_stops do |t|
      t.references :transport_route, null: false, foreign_key: true
      t.string :stop_name, null: false
      t.integer :stop_order, null: false
      t.time :arrival_time, null: false
      t.time :departure_time, null: false
      t.references :student, foreign_key: true

      t.timestamps
    end

    add_index :route_stops, [:transport_route_id, :stop_order], unique: true
  end
end
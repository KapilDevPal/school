class CreateRouteStops < ActiveRecord::Migration[8.0]
  def change
    create_table :route_stops do |t|
      t.references :transport_route, null: false, foreign_key: true
      t.string :stop_name
      t.integer :stop_order
      t.time :arrival_time
      t.time :departure_time
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end

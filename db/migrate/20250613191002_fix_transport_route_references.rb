class FixTransportRouteReferences < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :transport_routes, :drivers
    remove_foreign_key :transport_routes, :vehicles
    
    rename_column :transport_routes, :driver_id, :transport_driver_id
    rename_column :transport_routes, :vehicle_id, :transport_vehicle_id
    
    add_foreign_key :transport_routes, :transport_drivers
    add_foreign_key :transport_routes, :transport_vehicles
  end
end

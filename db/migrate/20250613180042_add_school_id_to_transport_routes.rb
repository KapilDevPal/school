class AddSchoolIdToTransportRoutes < ActiveRecord::Migration[8.0]
  def change
    add_reference :transport_routes, :school, null: false, foreign_key: true
  end
end

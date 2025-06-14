class MakeStudentIdNullableInRouteStops < ActiveRecord::Migration[7.0]
  def change
    change_column_null :route_stops, :student_id, true
  end
end

class MakeNoticeDatesNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :notices, :start_date, true
    change_column_null :notices, :end_date, true
    change_column_null :notices, :priority, true
  end
end 
class AddLeaveTypeAndContactNumberToLeaveApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :leave_applications, :leave_type, :string
    add_column :leave_applications, :contact_number, :string
  end
end

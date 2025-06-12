class AddStatusToLeaveApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :leave_applications, :status, :string, default: 'pending'
    add_column :leave_applications, :approved_by, :integer
    add_column :leave_applications, :rejection_reason, :text
  end
end 
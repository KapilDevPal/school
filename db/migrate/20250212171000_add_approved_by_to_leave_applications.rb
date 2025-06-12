class AddApprovedByToLeaveApplications < ActiveRecord::Migration[7.0]
  def change
    add_reference :leave_applications, :approved_by, foreign_key: { to_table: :school_owners }, null: true
  end
end 
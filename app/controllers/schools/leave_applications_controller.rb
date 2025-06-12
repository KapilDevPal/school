module Schools
  class LeaveApplicationsController < ApplicationController
    before_action :authenticate_school_owner!
    before_action :set_school
    before_action :set_leave_application, only: [:show, :approve, :reject]

    def index
      @leave_applications = @school.leave_applications.includes(:teacher).order(created_at: :desc)
    end

    def show
    end

    def approve
      if @leave_application.update(status: 'approved', approved_by: current_school_owner)
        redirect_to schools_leave_applications_path, notice: 'Leave application was successfully approved.'
      else
        redirect_to schools_leave_applications_path, alert: 'Failed to approve leave application.'
      end
    end

    def reject
      if @leave_application.update(status: 'rejected', approved_by: current_school_owner, rejection_reason: params[:rejection_reason])
        redirect_to schools_leave_applications_path, notice: 'Leave application was successfully rejected.'
      else
        redirect_to schools_leave_applications_path, alert: 'Failed to reject leave application.'
      end
    end

    private

    def set_school
      @school = current_school
    end

    def set_leave_application
      @leave_application = @school.leave_applications.find(params[:id])
    end
  end
end 
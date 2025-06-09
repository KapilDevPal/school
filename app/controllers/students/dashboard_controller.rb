module Students
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_student

    def index
      @student = current_user
      @class = @student.school_class
      @timetables = @student.school_class&.timetables
      @attendance = @student.attendance_records
    end

    private

    def ensure_student
      unless current_user.student?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
      end
    end
  end
end 
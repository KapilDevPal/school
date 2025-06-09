module Student
  class NoticesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_student

    def index
      @student = current_user.student
      @notices = @student.school.notices
        .where('target_audience = ? OR target_audience = ?', 'all', 'students')
        .order(created_at: :desc)
    end

    def show
      @notice = Notice.find(params[:id])
      unless @notice.target_audience.in?(['all', 'students'])
        redirect_to student_notices_path, alert: 'You do not have permission to view this notice.'
      end
    end

    private

    def ensure_student
      unless current_user.student?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
      end
    end
  end
end 
module Students
  class NoticesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_student

    def index
      @notices = current_user.student.school.notices.order(created_at: :desc)
    end

    def show
      @notice = Notice.find(params[:id])
    end

    private

    def ensure_student
      unless current_user.student?
        redirect_to root_path, alert: 'Access denied. Students only.'
      end
    end
  end
end 
module Student
  class TimetablesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_student

    def index
      @student = current_user.student
      @timetables = @student.school_class.timetables.includes(:subject, :teacher)
        .order(day_of_week: :asc, start_time: :asc)
    end

    private

    def ensure_student
      unless current_user.student?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
      end
    end
  end
end 
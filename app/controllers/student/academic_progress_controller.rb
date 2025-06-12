module Students
  class AcademicProgressController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_student

    def index
      @student = current_user.student
      @attendance = @student.attendance_records
      @exam_results = @student.exam_results
      @fees = @student.fees
    end

    def show
      @student = current_user.student
      @subject = Subject.find(params[:id])
      @exam_results = @student.exam_results.where(subject: @subject)
      @attendance = @student.attendance_records.joins(:school_class)
        .where(school_classes: { subject_id: @subject.id })
    end

    private

    def ensure_student
      unless current_user.student?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
      end
    end
  end
end 
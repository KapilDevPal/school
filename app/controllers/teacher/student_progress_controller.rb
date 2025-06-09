module Teacher
  class StudentProgressController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_teacher
    before_action :set_student, only: [:show]

    def index
      @students = current_user.teacher.school_classes.flat_map(&:students).uniq
    end

    def show
      @attendance = @student.attendance_records
      @exam_results = @student.exam_results
      @fees = @student.fees
    end

    private

    def set_student
      @student = Student.find(params[:id])
      unless current_user.teacher.school_classes.include?(@student.school_class)
        redirect_to teacher_student_progress_index_path, alert: 'You do not have access to this student.'
      end
    end

    def ensure_teacher
      unless current_user.teacher?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
      end
    end
  end
end 
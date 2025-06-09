module Teachers
  class StudentProgressController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher
    before_action :set_student, only: [:show]

    def index
      @school_classes = @teacher.school_classes.includes(students: [:attendance_records, :exam_results, :assignments])
    end

    def show
      @attendance_records = @student.attendance_records.where(school_class_id: @teacher.school_classes)
      @exam_results = @student.exam_results.where(school_class_id: @teacher.school_classes)
      @assignments = @student.assignments.where(school_class_id: @teacher.school_classes)
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end

    def set_student
      @student = Student.find(params[:id])
    end
  end
end 
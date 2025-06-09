module Teachers
  class AttendanceController < ApplicationController
    before_action :authenticate_user_or_school_owner!
    before_action :set_teacher
    before_action :set_school_class, only: [:index, :create]

    def index
      @students = @school_class.students.order(:roll_number)
      @attendance_records = @school_class.attendance_records.where(date: Date.today)
    end

    def create
      @students = @school_class.students.order(:roll_number)
      
      ActiveRecord::Base.transaction do
        params[:attendance].each do |student_id, status|
          student = @students.find(student_id)
          attendance = @school_class.attendance_records.find_or_initialize_by(
            student: student,
            date: Date.today
          )
          attendance.status = status
          attendance.save!
        end
      end

      redirect_to teacher_attendance_index_path(school_class_id: @school_class.id), notice: 'Attendance marked successfully.'
    rescue ActiveRecord::RecordInvalid
      render :index, status: :unprocessable_entity
    end

    private

    def set_teacher
      @teacher = current_user.teacher
      redirect_to root_path, alert: 'Access denied' unless @teacher
    end

    def set_school_class
      @school_class = @teacher.school_classes.find(params[:school_class_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to teachers_root_path, alert: 'Class not found'
    end
  end
end 
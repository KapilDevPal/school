module Teachers
  class StudentAttendancesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_teacher
    before_action :set_school_class, only: [:index, :create]

    def index
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      @students = @school_class.students
      @attendances = AttendanceRecord.where(school_class: @school_class, date: @date)
        .index_by(&:student_id)
    end

    def create
      @date = Date.parse(params[:date])
      @students = @school_class.students

      ActiveRecord::Base.transaction do
        params[:attendance].each do |student_id, status|
          AttendanceRecord.find_or_initialize_by(
            student_id: student_id,
            school_class: @school_class,
            date: @date
          ).update!(
            status: status,
            remarks: params[:remarks][student_id]
          )
        end
      end

      redirect_to teacher_student_attendances_path(@school_class, date: @date), 
                  notice: 'Student attendance marked successfully.'
    rescue ActiveRecord::RecordInvalid
      render :index, status: :unprocessable_entity
    end

    private

    def ensure_teacher
      unless current_user.teacher?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
      end
    end

    def set_school_class
      @school_class = current_user.school_classes.find(params[:school_class_id])
    end
  end
end 
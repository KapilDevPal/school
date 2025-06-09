module Teacher
  class AttendanceController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher
    before_action :set_school_class, only: [:index, :create]

    def index
      @students = @school_class.students.includes(:attendance_records)
      @attendance_records = @students.map do |student|
        student.attendance_records.find_or_initialize_by(
          date: Date.today,
          school_class: @school_class,
          school: @teacher.school
        )
      end
    end

    def create
      @students = @school_class.students
      success = true

      ActiveRecord::Base.transaction do
        params[:attendance].each do |student_id, status|
          student = @students.find(student_id)
          attendance_record = student.attendance_records.find_or_initialize_by(
            date: Date.today,
            school_class: @school_class,
            school: @teacher.school
          )
          
          unless attendance_record.update(status: status)
            success = false
            break
          end
        end
      end

      if success
        redirect_to teacher_attendance_index_path(school_class_id: @school_class.id), notice: 'Attendance marked successfully.'
      else
        @attendance_records = @students.map do |student|
          student.attendance_records.find_or_initialize_by(
            date: Date.today,
            school_class: @school_class,
            school: @teacher.school
          )
        end
        render :index, status: :unprocessable_entity
      end
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end

    def set_school_class
      @school_class = @teacher.classes.find(params[:school_class_id])
    end
  end
end 
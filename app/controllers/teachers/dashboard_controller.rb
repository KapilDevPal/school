module Teachers
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher

    def index
      @school_classes = @teacher.school_classes
      @class_ids = @school_classes.pluck(:id)
      @school = @teacher.school
      @upcoming_classes = @school_classes.joins(:timetables)
                                       .where('timetables.start_time > ?', Time.current)
                                       .exists?
      @has_notices = @school.notices.exists?
    end

    def mark_attendance
      @attendance = TeacherAttendance.find_or_initialize_by(
        teacher: current_user,
        school: current_school,
        date: Date.today
      )

      if @attendance.update(attendance_params)
        redirect_to teacher_dashboard_path, notice: 'Attendance marked successfully.'
      else
        redirect_to teacher_dashboard_path, alert: 'Failed to mark attendance.'
      end
    end

    def apply_leave
      @leave = current_user.leaves.build(leave_params)
      @leave.school = current_school

      if @leave.save
        redirect_to teacher_dashboard_path, notice: 'Leave application submitted successfully.'
      else
        redirect_to teacher_dashboard_path, alert: 'Failed to submit leave application.'
      end
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end

    def attendance_params
      params.require(:teacher_attendance).permit(:status, :remarks)
    end

    def leave_params
      params.require(:leave).permit(:start_date, :end_date, :reason, :leave_type)
    end
  end
end 
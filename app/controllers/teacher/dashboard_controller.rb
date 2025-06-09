class Teacher::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_teacher_role

  def index
    @teacher = current_user.teacher
    @classes = @teacher.classes
    @upcoming_classes = @teacher.classes.joins(:timetables)
                              .where('timetables.start_time > ?', Time.current)
                              .order('timetables.start_time')
    @recent_attendance = AttendanceRecord.joins(:school_class)
                                       .where(school_classes: { id: @classes.pluck(:id) })
                                       .where(date: Date.today)
                                       .order(created_at: :desc)
                                       .limit(5)
    @notices = @teacher.school.notices.order(created_at: :desc).limit(5)
  end

  private

  def ensure_teacher_role
    unless current_user.teacher?
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end
end 
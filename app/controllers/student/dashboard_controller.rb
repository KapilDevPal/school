class Student::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_student_role

  def index
    @student = current_user.student
    @upcoming_classes = @student.classes.joins(:timetables)
                              .where('timetables.start_time > ?', Time.current)
                              .order('timetables.start_time')
    @recent_attendance = @student.attendance_records
                                .order(created_at: :desc)
                                .limit(5)
    @notices = @student.school.notices.order(created_at: :desc).limit(5)
    @fees_due = @student.fees.where('due_date > ?', Time.current)
                       .order(due_date: :asc)
                       .limit(5)
  end

  private

  def ensure_student_role
    unless current_user.student?
      redirect_to root_path, alert: 'You are not authorized to access this page.'
    end
  end
end 
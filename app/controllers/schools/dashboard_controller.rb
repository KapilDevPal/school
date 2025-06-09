class Schools::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_school_owner_role

  def index
    @school = current_user.school
    @teachers = @school.teachers.includes(:classes)
    @students = @school.students.includes(:classes)
    @classes = @school.classes.includes(:students, :teachers)
    @recent_notices = @school.notices.order(created_at: :desc).limit(5)
    @upcoming_events = @school.calendar_events.where('start_time > ?', Time.current)
                            .order(start_time: :asc)
                            .limit(5)
    @pending_fees = @school.fees.where(status: 'pending')
                         .order(due_date: :asc)
                         .limit(5)
  end

  private

  def ensure_school_owner_role
    unless current_user.school_owner?
      redirect_to root_path, alert: 'You are not authorized to access this area.'
    end
  end
end 
class Teacher::LeaveApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher
  before_action :set_leave_application, only: [:show]

  def index
    @leave_applications = @teacher.leave_applications.order(created_at: :desc)
  end

  def new
    @leave_application = @teacher.leave_applications.build
  end

  def create
    @leave_application = @teacher.leave_applications.build(leave_application_params)

    if @leave_application.save
      redirect_to teacher_leave_applications_path, notice: 'Leave application submitted successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_teacher
    @teacher = current_user.teacher
  end

  def set_leave_application
    @leave_application = @teacher.leave_applications.find(params[:id])
  end

  def leave_application_params
    params.require(:leave_application).permit(
      :start_date,
      :end_date,
      :reason,
      :leave_type,
      :contact_number
    )
  end
end 
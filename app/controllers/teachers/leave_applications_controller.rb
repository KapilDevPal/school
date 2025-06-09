module Teachers
  class LeaveApplicationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher
    before_action :set_leave_application, only: [:show, :edit, :update, :destroy]

    def index
      @leave_applications = @teacher.leave_applications.order(created_at: :desc)
    end

    def new
      @leave_application = @teacher.leave_applications.build
    end

    def create
      @leave_application = @teacher.leave_applications.build(leave_application_params)

      if @leave_application.save
        redirect_to teachers_leave_application_path(@leave_application), notice: 'Leave application was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      if @leave_application.update(leave_application_params)
        redirect_to teachers_leave_application_path(@leave_application), notice: 'Leave application was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @leave_application.destroy
      redirect_to teachers_leave_applications_path, notice: 'Leave application was successfully deleted.'
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end

    def set_leave_application
      @leave_application = @teacher.leave_applications.find(params[:id])
    end

    def leave_application_params
      params.require(:leave_application).permit(:start_date, :end_date, :reason, :status)
    end
  end
end 
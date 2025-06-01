module Schools
  class TeachersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_feature_enabled
    before_action :set_teacher, only: [:show, :edit, :update, :destroy]

    def index
      @teachers = current_school.teachers
    end

    def show
    end

    def new
      @teacher = current_school.teachers.build
    end

    def create
      @teacher = current_school.teachers.build(teacher_params)

      if @teacher.save
        redirect_to schools_teachers_path, notice: 'Teacher was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @teacher.update(teacher_params)
        redirect_to schools_teachers_path, notice: 'Teacher was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @teacher.destroy
      redirect_to schools_teachers_path, notice: 'Teacher was successfully deleted.'
    end

    private

    def set_teacher
      @teacher = current_school.teachers.find(params[:id])
    end

    def teacher_params
      params.require(:teacher).permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone_number)
    end

    def check_feature_enabled
      unless feature_enabled?(:employee_management)
        redirect_to root_path, alert: 'Employee management feature is not enabled for this school.'
      end
    end
  end
end 
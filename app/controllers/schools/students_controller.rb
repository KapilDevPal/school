module Schools
  class StudentsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_feature_enabled
    before_action :set_student, only: [:show, :edit, :update, :destroy]

    def index
      @students = current_school.students.includes(:school_class)
    end

    def show
    end

    def new
      @student = current_school.students.build
    end

    def create
      @student = current_school.students.build(student_params)

      if @student.save
        redirect_to schools_students_path, notice: 'Student was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @student.update(student_params)
        redirect_to schools_students_path, notice: 'Student was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @student.destroy
      redirect_to schools_students_path, notice: 'Student was successfully deleted.'
    end

    private

    def set_student
      @student = current_school.students.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name, :email, :phone_number, :date_of_birth, :gender, :address, :school_class_id)
    end

    def check_feature_enabled
      unless feature_enabled?(:student_management)
        redirect_to root_path, alert: 'Student management feature is not enabled for this school.'
      end
    end
  end
end 
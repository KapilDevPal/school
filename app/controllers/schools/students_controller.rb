module Schools
  class StudentsController < ApplicationController
    before_action :authenticate_school_owner!
    before_action :check_feature_enabled
    before_action :set_student, only: [:show, :edit, :update, :destroy]

    def index
      @students = current_school.students
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
      params.require(:student).permit(:email, :password, :password_confirmation, :first_name, :last_name, 
                                    :admission_number, :class_section, :date_of_birth, :phone_number)
    end

    def check_feature_enabled
      unless feature_enabled?(:students)
        redirect_to root_path, alert: 'Students feature is not enabled for this school.'
      end
    end
  end
end 
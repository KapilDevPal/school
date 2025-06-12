module Schools
  class StudentsController < ApplicationController
    before_action :authenticate_school_owner!
    before_action :check_feature_enabled
    before_action :set_school
    before_action :set_student, only: [:show, :edit, :update, :destroy]

    def index
      @students = @school.students
    end

    def show
    end

    def new
      @student = @school.students.build
      @student.build_admission_detail
    end

    def create  
      @student = @school.students.build(student_params)
      @student.password = "123456789"
      @student.user_id = current_school_owner.id
      if @student.save
        redirect_to schools_school_students_path(@school), notice: 'Student was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
       @student = @school.students.find(params[:id])
       @student.build_admission_detail if @student.admission_detail.nil?
    end

    def update
      if @student.update(student_params)
        redirect_to schools_school_students_path(@school), notice: 'Student was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @student.destroy
      redirect_to schools_school_students_path(@school), notice: 'Student was successfully deleted.'
    end

    private

    def set_school
      @school = current_school
    end

    def set_student
      @student = @school.students.find(params[:id])
    end

   
    def student_params
     params.require(:student).permit(
      :first_name, :last_name, :email, :date_of_birth, :gender,
      :admission_number, :parent_name, :address, :school_class_id, :roll_number, :parent_phone, :parent_email,
      admission_detail_attributes: [
        :aadhaar_number,
        :ssmid_number,
        :scholar_no,
        :family_id,
        :place_of_birth,
        :nationality,
        :mother_tongue,
        :other_languages,
        :category,
        :subcategory,
        :religion,
        :father_name,
        :father_mobile,
        :father_email,
        :father_occupation,
        :father_income,
        :mother_name,
        :mother_mobile,
        :mother_email,
        :mother_occupation,
        :mother_income,
        :total_family_income
      ]
      )
    end

    def check_feature_enabled
      unless feature_enabled?(:students)
        redirect_to root_path, alert: 'Students feature is not enabled for this school.'
      end
    end
  end
end 
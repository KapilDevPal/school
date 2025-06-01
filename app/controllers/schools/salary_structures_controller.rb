module Schools
  class SalaryStructuresController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher
    before_action :set_salary_structure, only: [:show, :edit, :update, :destroy]

    def index
      @salary_structures = current_school.salary_structures.includes(:teacher)
    end

    def show
    end

    def new
      @salary_structure = current_school.salary_structures.build(teacher: @teacher)
    end

    def create
      @salary_structure = current_school.salary_structures.build(salary_structure_params)
      @salary_structure.teacher = @teacher

      if @salary_structure.save
        redirect_to schools_salary_structures_path, notice: 'Salary structure was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @salary_structure.update(salary_structure_params)
        redirect_to schools_salary_structures_path, notice: 'Salary structure was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @salary_structure.destroy
      redirect_to schools_salary_structures_path, notice: 'Salary structure was successfully deleted.'
    end

    private

    def set_teacher
      @teacher = current_school.teachers.find(params[:teacher_id]) if params[:teacher_id]
    end

    def set_salary_structure
      @salary_structure = current_school.salary_structures.find(params[:id])
    end

    def salary_structure_params
      params.require(:salary_structure).permit(
        :basic_salary,
        :house_rent_allowance,
        :dearness_allowance,
        :travel_allowance,
        :medical_allowance,
        :notes
      )
    end
  end
end 
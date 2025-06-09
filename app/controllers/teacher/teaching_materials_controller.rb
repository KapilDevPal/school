module Teacher
  class TeachingMaterialsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher
    before_action :set_teaching_material, only: [:show, :edit, :update, :destroy]

    def index
      @teaching_materials = @teacher.teaching_materials.order(created_at: :desc)
    end

    def show
    end

    def new
      @teaching_material = @teacher.teaching_materials.build
    end

    def create
      @teaching_material = @teacher.teaching_materials.build(teaching_material_params)

      if @teaching_material.save
        redirect_to teacher_teaching_materials_path, notice: 'Teaching material was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @teaching_material.update(teaching_material_params)
        redirect_to teacher_teaching_materials_path, notice: 'Teaching material was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @teaching_material.destroy
      redirect_to teacher_teaching_materials_path, notice: 'Teaching material was successfully deleted.'
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end

    def set_teaching_material
      @teaching_material = @teacher.teaching_materials.find(params[:id])
    end

    def teaching_material_params
      params.require(:teaching_material).permit(
        :title,
        :description,
        :file,
        :subject,
        :grade_level,
        :material_type
      )
    end
  end
end 
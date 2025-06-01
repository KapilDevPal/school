module Schools
  class ClassesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_feature_enabled
    before_action :set_school_class, only: [:show, :edit, :update, :destroy]

    def index
      @school_classes = current_school.school_classes.includes(:students)
    end

    def show
    end

    def new
      @school_class = current_school.school_classes.build
    end

    def create
      @school_class = current_school.school_classes.build(school_class_params)

      if @school_class.save
        redirect_to schools_classes_path, notice: 'Class was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @school_class.update(school_class_params)
        redirect_to schools_classes_path, notice: 'Class was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @school_class.destroy
      redirect_to schools_classes_path, notice: 'Class was successfully deleted.'
    end

    private

    def set_school_class
      @school_class = current_school.school_classes.find(params[:id])
    end

    def school_class_params
      params.require(:school_class).permit(:name, :grade, :section, :room_number, :capacity, :teacher_id)
    end

    def check_feature_enabled
      unless feature_enabled?(:student_management)
        redirect_to root_path, alert: 'Student management feature is not enabled for this school.'
      end
    end
  end
end 
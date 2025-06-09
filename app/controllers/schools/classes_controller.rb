module Schools
  class ClassesController < ApplicationController
    before_action :authenticate_school_owner!
    before_action :check_feature_enabled
    before_action :set_class, only: [:show, :edit, :update, :destroy]

    def index
      @classes = current_school.school_classes
    end

    def show
    end

    def new
      @class = current_school.school_classes.build
    end

    def create
      @class = current_school.school_classes.build(class_params)

      if @class.save
        redirect_to schools_classes_path, notice: 'Class was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @class.update(class_params)
        redirect_to schools_classes_path, notice: 'Class was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @class.destroy
      redirect_to schools_classes_path, notice: 'Class was successfully deleted.'
    end

    private

    def set_class
      @class = current_school.school_classes.find(params[:id])
    end

    def class_params
      params.require(:school_class).permit(:name, :grade, :section, :teacher_id, :room_number, :capacity)
    end

    def check_feature_enabled
      unless feature_enabled?(:classes)
        redirect_to root_path, alert: 'Classes feature is not enabled for this school.'
      end
    end
  end
end 
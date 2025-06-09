module Schools
  class ExamsController < ApplicationController
    before_action :authenticate_school_owner!
    before_action :check_feature_enabled
    before_action :set_exam, only: [:show, :edit, :update, :destroy]

    def index
      @exams = current_school.exams
    end

    def show
    end

    def new
      @exam = current_school.exams.build
    end

    def create
      @exam = current_school.exams.build(exam_params)

      if @exam.save
        redirect_to schools_exams_path, notice: 'Exam was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @exam.update(exam_params)
        redirect_to schools_exams_path, notice: 'Exam was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @exam.destroy
      redirect_to schools_exams_path, notice: 'Exam was successfully deleted.'
    end

    private

    def set_exam
      @exam = current_school.exams.find(params[:id])
    end

    def exam_params
      params.require(:exam).permit(:name, :start_date, :end_date, :description, :school_class_id)
    end

    def check_feature_enabled
      unless feature_enabled?(:exams)
        redirect_to root_path, alert: 'Exams feature is not enabled for this school.'
      end
    end
  end
end 
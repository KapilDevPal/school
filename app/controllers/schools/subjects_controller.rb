module Schools
  class SubjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_feature_enabled
    before_action :set_subject, only: [:show, :edit, :update, :destroy]

    def index
      @subjects = Subject.all
    end

    def show
    end

    def new
      @subject = Subject.new
    end

    def edit
    end

    def create
      @subject = Subject.new(subject_params)

      if @subject.save
        redirect_to schools_subject_path(@subject), notice: 'Subject was successfully created.'
      else
        render :new
      end
    end

    def update
      if @subject.update(subject_params)
        redirect_to schools_subject_path(@subject), notice: 'Subject was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @subject.destroy
      redirect_to schools_subjects_path, notice: 'Subject was successfully deleted.'
    end

    private

    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:name, :code, :description, :credits)
    end

    def check_feature_enabled
      unless feature_enabled?(:subjects)
        redirect_to root_path, alert: 'Subjects feature is not enabled for this school.'
      end
    end
  end
end 
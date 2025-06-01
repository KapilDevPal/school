module Schools
  class TimetablesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_feature_enabled
    before_action :set_timetable, only: [:show, :edit, :update, :destroy]

    def index
      @school_classes = current_school.school_classes
      @timetables = current_school.timetables.includes(:school_class, :subject, :teacher)
      @time_slots = [
        "09:00 - 10:00",
        "10:00 - 11:00",
        "11:00 - 12:00",
        "12:00 - 13:00",
        "13:00 - 14:00",
        "14:00 - 15:00",
        "15:00 - 16:00"
      ]
    end

    def show
    end

    def new
      @timetable = current_school.timetables.build
    end

    def create
      @timetable = current_school.timetables.build(timetable_params)

      if @timetable.save
        redirect_to schools_timetables_path, notice: 'Schedule was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @timetable.update(timetable_params)
        redirect_to schools_timetables_path, notice: 'Schedule was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @timetable.destroy
      redirect_to schools_timetables_path, notice: 'Schedule was successfully deleted.'
    end

    private

    def set_timetable
      @timetable = current_school.timetables.find(params[:id])
    end

    def timetable_params
      params.require(:timetable).permit(:school_class_id, :subject_id, :teacher_id, :day_of_week, :start_time, :end_time, :room_number)
    end

    def check_feature_enabled
      unless feature_enabled?(:timetable)
        redirect_to root_path, alert: 'Timetable feature is not enabled for this school.'
      end
    end
  end
end 
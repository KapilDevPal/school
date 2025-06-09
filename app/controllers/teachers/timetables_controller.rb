module Teachers
  class TimetablesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher

    def index
      @school_classes = @teacher.school_classes.includes(:timetables)
      @timetables = Timetable.where(school_class_id: @school_classes.pluck(:id))
                            .order(:start_time)
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end
  end
end 
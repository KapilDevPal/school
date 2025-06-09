module Teacher
  class TimetablesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher

    def index
      @school_classes = @teacher.classes.includes(:timetables)
      @timetables = @school_classes.flat_map(&:timetables).sort_by(&:start_time)
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end
  end
end 
module Teachers
  class TimetablesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher
    before_action :set_school

    def index
      @timetables = Timetable.joins(:school_class)
                            .joins("INNER JOIN teacher_classes ON teacher_classes.school_class_id = school_classes.id")
                            .where(teacher_classes: { teacher_id: @teacher.id })
                            .order(:day_of_week, :start_time)
      
      @time_slots = @timetables.map { |t| t.start_time }.uniq.sort
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end

    def set_school
      @school = @teacher.school
    end
  end
end 
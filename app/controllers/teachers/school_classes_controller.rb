module Teachers
  class SchoolClassesController < ApplicationController
    before_action :authenticate_user_or_school_owner!
    before_action :set_teacher
    before_action :set_school_class, only: [:show]

    def index
      @school_classes = @teacher.school_classes.includes(:students)
    end

    def show
      @students = @school_class.students
      @timetables = @school_class.timetables.includes(:subject, :teacher)
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end

    def set_school_class
      @school_class = @teacher.school_classes.find(params[:id])
    end
  end
end 
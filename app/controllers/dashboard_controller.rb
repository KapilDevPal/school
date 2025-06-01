class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @school = current_user.school
    @students_count = @school.students.count
    @teachers_count = @school.users.where(role: :teacher).count
    @classes_count = @school.school_classes.count
  end
end

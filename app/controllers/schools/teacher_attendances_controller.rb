module Schools
  class TeacherAttendancesController < ApplicationController
    before_action :authenticate_user!

    def index
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      @teachers = current_school.teachers
      @attendances = TeacherAttendance.where(school: current_school, date: @date).index_by(&:teacher_id)
    end

    def create
      @date = Date.parse(params[:date])
      @teachers = current_school.teachers
      ActiveRecord::Base.transaction do
        params[:attendance].each do |teacher_id, status|
          TeacherAttendance.find_or_initialize_by(teacher_id: teacher_id, school: current_school, date: @date).update!(
            status: status,
            remarks: params[:remarks][teacher_id]
          )
        end
      end
      redirect_to schools_teacher_attendances_path(date: @date), notice: 'Teacher attendance marked successfully.'
    rescue ActiveRecord::RecordInvalid
      render :index, status: :unprocessable_entity
    end
  end
end 
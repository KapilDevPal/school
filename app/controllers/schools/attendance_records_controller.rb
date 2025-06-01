module Schools
  class AttendanceRecordsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_feature_enabled

    def index
      @attendance_records = AttendanceRecord.where(school: current_school)
    end

    private

    def check_feature_enabled
      unless feature_enabled?(:attendance)
        redirect_to root_path, alert: 'Attendance feature is not enabled for this school.'
      end
    end
  end
end 
module Schools
  class AttendanceController < ApplicationController
    before_action :authenticate_user!
    # Add your actions here (index, create, etc.)
    def index
      # Placeholder action
      render plain: "Attendance index works!"
    end
  end
end 
module Admin
  class ModuleSettingsController < Admin::BaseController
    before_action :set_school, only: [:show, :update]

    def index
      @schools = School.all
    end

    def show
      @available_modules = [
        { id: 'students', name: 'Students Management', description: 'Manage students, classes, and attendance' },
        { id: 'teachers', name: 'Teachers Management', description: 'Manage teachers and their schedules' },
        { id: 'finance', name: 'Finance Management', description: 'Manage fees, payments, and financial reports' },
        { id: 'exams', name: 'Exams Management', description: 'Manage exams, results, and report cards' },
        { id: 'library', name: 'Library Management', description: 'Manage books, borrowing, and returns' },
        { id: 'transport', name: 'Transport Management', description: 'Manage routes, vehicles, and schedules' }
      ]
    end

    def update
      if @school.update(school_params)
        redirect_to admin_module_settings_path(@school), notice: 'Module settings updated successfully.'
      else
        redirect_to admin_module_settings_path(@school), alert: 'Failed to update module settings.'
      end
    end

    private

    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(features_enabled: [])
    end
  end
end 
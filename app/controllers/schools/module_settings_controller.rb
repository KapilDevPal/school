module Schools
  class ModuleSettingsController < ApplicationController
    before_action :authenticate_user_or_school_owner!
    before_action :set_school

    def show
    end

    def update
      if @school.update(features_params)
        redirect_to schools_module_settings_path, notice: 'Module settings were successfully updated.'
      else
        render :show
      end
    end

    private

    def set_school
      @school = if user_signed_in?
                  current_user.school
                else
                  current_school_owner.school
                end
    end

    def features_params
      params.require(:school).permit(features_enabled: [])
    end

    def authenticate_user_or_school_owner!
      unless user_signed_in? || school_owner_signed_in?
        redirect_to new_user_session_path, alert: 'Please sign in to access this page.'
      end
    end
  end
end 
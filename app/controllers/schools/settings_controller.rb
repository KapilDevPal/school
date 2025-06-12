module Schools
  class SettingsController < ApplicationController
    before_action :authenticate_school_owner!
    before_action :set_school

    def edit
    end

    def update
      if @school.update(school_params)
        redirect_to edit_schools_settings_path, notice: 'School settings were successfully updated.'
      else
        render :edit
      end
    end

    private

    def set_school
      @school = current_school
    end

    def school_params
      params.require(:school).permit(
        :primary_color,
        :secondary_color,
        :accent_color,
        :background_color,
        :text_color
      )
    end
  end
end 
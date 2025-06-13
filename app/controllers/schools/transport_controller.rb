module Schools
  class TransportController < ApplicationController
    before_action :authenticate_user_or_school_owner!
    before_action :check_feature_enabled

    def index
      @transport_routes = current_school.transport_routes
    end

    private

    def check_feature_enabled
      unless current_school.feature_enabled?('transport')
        redirect_to schools_dashboard_path, alert: 'Transport feature is not enabled for your school.'
      end
    end
  end
end 
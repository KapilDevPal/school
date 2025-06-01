module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @schools = School.all
      @total_users = User.count
      @total_schools = School.count
      @active_schools = School.where('subscription_ends_at > ?', Time.current).count
    end

    private

    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: 'You are not authorized to access this area.'
      end
    end
  end
end 
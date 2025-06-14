module Schools
  class TransportDriversController < ApplicationController
    before_action :authenticate_user_or_school_owner!
    before_action :check_feature_enabled
    before_action :set_driver, only: [:show, :edit, :update, :destroy]

    def index
      @transport_drivers = current_school.transport_drivers
    end

    def show
    end

    def new
      @transport_driver = current_school.transport_drivers.build
    end

    def create
      @transport_driver = current_school.transport_drivers.build(transport_driver_params)

      if @transport_driver.save
        redirect_to schools_transport_drivers_path, notice: 'Driver was successfully registered.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @transport_driver.update(transport_driver_params)
        redirect_to schools_transport_drivers_path, notice: 'Driver was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @transport_driver.destroy
      redirect_to schools_transport_drivers_path, notice: 'Driver was successfully deleted.'
    end

    private

    def set_driver
      @transport_driver = current_school.transport_drivers.find(params[:id])
    end

    def transport_driver_params
      params.require(:transport_driver).permit(:name, :license_number, :phone, :email, :status, :active)
    end

    def check_feature_enabled
      unless current_school.feature_enabled?('transport')
        redirect_to schools_dashboard_path, alert: 'Transport feature is not enabled for your school.'
      end
    end
  end
end 
module Schools
  class TransportVehiclesController < ApplicationController
    before_action :authenticate_user_or_school_owner!
    before_action :check_feature_enabled

    def index
      @transport_vehicles = current_school.transport_vehicles
    end

    def new
      @transport_vehicle = current_school.transport_vehicles.build
    end

    def create
      @transport_vehicle = current_school.transport_vehicles.build(transport_vehicle_params)

      if @transport_vehicle.save
        redirect_to schools_transport_vehicles_path, notice: 'Vehicle was successfully registered.'
      else
        render :new
      end
    end

    def edit
      @transport_vehicle = current_school.transport_vehicles.find(params[:id])
    end

    def update
      @transport_vehicle = current_school.transport_vehicles.find(params[:id])

      if @transport_vehicle.update(transport_vehicle_params)
        redirect_to schools_transport_vehicles_path, notice: 'Vehicle was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @transport_vehicle = current_school.transport_vehicles.find(params[:id])
      @transport_vehicle.destroy
      redirect_to schools_transport_vehicles_path, notice: 'Vehicle was successfully deleted.'
    end

    private

    def transport_vehicle_params
      params.require(:transport_vehicle).permit(:name, :registration_number, :vehicle_type, :capacity, :status, :active)
    end

    def check_feature_enabled
      unless current_school.feature_enabled?('transport')
        redirect_to schools_dashboard_path, alert: 'Transport feature is not enabled for your school.'
      end
    end
  end
end 
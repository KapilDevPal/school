railmodule Schools
  class TransportRoutesController < ApplicationController
    before_action :authenticate_user_or_school_owner!
    before_action :set_transport_route, only: [:show, :edit, :update, :destroy]
    before_action :check_feature_enabled
    before_action :load_vehicles_and_drivers, only: [:new, :create, :edit, :update]

    def index
      @transport_routes = current_school.transport_routes.order(created_at: :desc)
    end

    def show
    end

    def new
      @transport_route = current_school.transport_routes.build
      @transport_route.route_stops.build
    end

    def edit
    end

    def create
      @transport_route = current_school.transport_routes.build(transport_route_params)

      if @transport_route.save
        redirect_to schools_transport_routes_path, notice: 'Transport route was successfully created.'
      else
        render :new
      end
    end

    def update
      if @transport_route.update(transport_route_params)
        redirect_to schools_transport_routes_path, notice: 'Transport route was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @transport_route.destroy
      redirect_to schools_transport_routes_path, notice: 'Transport route was successfully deleted.'
    end

    private

    def set_transport_route
      @transport_route = current_school.transport_routes.find(params[:id])
    end

    def transport_route_params
      params.require(:transport_route).permit(
        :name, :cost, :vehicle_id, :driver_id, :active,
        route_stops_attributes: [:id, :stop_name, :stop_order, :arrival_time, :departure_time, :_destroy]
      )
    end

    def load_vehicles_and_drivers
      @vehicles = current_school.transport_vehicles.active
      @drivers = current_school.transport_drivers.active
    end

    def check_feature_enabled
      unless current_school.feature_enabled?('transport')
        redirect_to root_path, alert: 'Transport feature is not enabled for your school.'
      end
    end
  end
end 
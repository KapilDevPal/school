class TransportController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_transport_access

  def index
    @routes = TransportRoute.includes(:vehicle, :driver).all
  end

  def new_route
    @route = TransportRoute.new
    @vehicles = Vehicle.active
    @drivers = Driver.active
  end

  def create_route
    @route = TransportRoute.new(route_params)
    if @route.save
      redirect_to transport_path, notice: 'Route was successfully created.'
    else
      @vehicles = Vehicle.active
      @drivers = Driver.active
      render :new_route
    end
  end

  def edit_route
    @route = TransportRoute.find(params[:id])
    @vehicles = Vehicle.active
    @drivers = Driver.active
  end

  def update_route
    @route = TransportRoute.find(params[:id])
    if @route.update(route_params)
      redirect_to transport_path, notice: 'Route was successfully updated.'
    else
      @vehicles = Vehicle.active
      @drivers = Driver.active
      render :edit_route
    end
  end

  def destroy_route
    @route = TransportRoute.find(params[:id])
    @route.destroy
    redirect_to transport_path, notice: 'Route was successfully deleted.'
  end

  private

  def route_params
    params.require(:transport_route).permit(
      :name, :start_point, :end_point, :vehicle_id, :driver_id, :active,
      route_stops_attributes: [:id, :stop_name, :stop_order, :arrival_time, :departure_time, :_destroy]
    )
  end

  def authorize_transport_access
    unless current_user.accountant? || current_user.school_owner?
      redirect_to root_path, alert: 'You are not authorized to access this section.'
    end
  end
end 
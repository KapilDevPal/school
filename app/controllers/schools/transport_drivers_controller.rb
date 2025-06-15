class Schools::TransportDriversController < ApplicationController
  before_action :set_school
  before_action :set_driver, only: [:edit, :update, :destroy]

  def index
    @drivers = @school.transport_drivers
  end

  def new
    @driver = @school.transport_drivers.build
  end

  def create
    @driver = @school.transport_drivers.build(driver_params)

    if @driver.save
      redirect_to schools_transport_drivers_path, notice: 'Driver was successfully registered.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @driver.update(driver_params)
      redirect_to schools_transport_drivers_path, notice: 'Driver information was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @driver.destroy
    redirect_to schools_transport_drivers_path, notice: 'Driver was successfully removed.'
  end

  private

  def set_school
    @school = current_school
  end

  def set_driver
    @driver = @school.transport_drivers.find(params[:id])
  end

  def driver_params
    params.require(:transport_driver).permit(:name, :license_number, :phone, :email, :status, :active)
  end
end

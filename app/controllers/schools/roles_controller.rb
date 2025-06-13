class Schools::RolesController < ApplicationController
  before_action :authenticate_user_or_school_owner!
  before_action :set_role, only: [:edit, :update, :destroy]
  before_action :check_feature_enabled

  def index
    @roles = current_school.roles.active.order(:name)
  end

  def new
    @role = current_school.roles.build
  end

  def create
    @role = current_school.roles.build(role_params)

    if @role.save
      redirect_to schools_roles_path, notice: 'Role was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @role.update(role_params)
      redirect_to schools_roles_path, notice: 'Role was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @role.update(active: false)
    redirect_to schools_roles_path, notice: 'Role was successfully deleted.'
  end

  private

  def set_role
    @role = current_school.roles.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, permissions: [])
  end

  def check_feature_enabled
    unless current_school.feature_enabled?('staff_management')
      redirect_to root_path, alert: 'Staff management feature is not enabled for your school.'
    end
  end
end 
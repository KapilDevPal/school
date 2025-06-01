class SchoolOwner::SchoolsController < ApplicationController
  before_action :authenticate_school_owner!
  before_action :set_school, only: [:show, :edit, :update]

  def index
    @schools = current_school_owner.schools
    @current_school = if params[:school_id]
      @schools.find_by(id: params[:school_id])
    else
      @schools.first
    end

    if @current_school
      # Store the current school in the session
      session[:current_school_id] = @current_school.id
      redirect_to school_owner_school_path(@current_school)
    else
      redirect_to school_owner_path, alert: 'No schools available.'
    end
  end

  def show
    @school = current_school_owner.schools.find(params[:id])
    session[:current_school_id] = @school.id
  end

  def edit
  end

  def update
    if @school.update(school_params)
      redirect_to school_owner_school_path(@school), notice: 'School was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_school
    @school = current_school_owner.schools.find(params[:id])
  end

  def school_params
    params.require(:school).permit(:name, :domain)
  end
end 
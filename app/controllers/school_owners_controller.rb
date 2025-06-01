class SchoolOwnersController < ApplicationController
  before_action :authenticate_school_owner!
  before_action :set_school_owner, only: [:show, :edit, :update]

  def show
    @school_owner = current_school_owner
    @schools = @school_owner.schools
    @current_school = if params[:school_id]
      @schools.find_by(id: params[:school_id])
    else
      @schools.first
    end
  end

  def edit
  end

  def update
    if @school_owner.update(school_owner_params)
      redirect_to @school_owner, notice: 'Profile was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_school_owner
    @school_owner = current_school_owner
  end

  def school_owner_params
    params.require(:school_owner).permit(:first_name, :last_name, :email, :phone_number)
  end
end 
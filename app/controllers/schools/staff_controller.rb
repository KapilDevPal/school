class Schools::StaffController < ApplicationController
  before_action :authenticate_user_or_school_owner!
  before_action :set_staff, only: [:show, :edit, :update, :destroy]
  before_action :check_feature_enabled
  before_action :load_roles, only: [:new, :create, :edit, :update]

  def index
    @staff = current_school.users.where.not(role_id: nil).includes(:role).order(:first_name)
  end

  def show
  end

  def new
    @staff = current_school.users.build
  end

  def create
    @staff = current_school.users.build(staff_params)
    @staff.password = SecureRandom.hex(8) # Generate a random password

    if @staff.save
      # Send welcome email with password
      StaffMailer.welcome_email(@staff, @staff.password).deliver_later
      redirect_to schools_staff_index_path, notice: 'Staff member was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @staff.update(staff_params)
      redirect_to schools_staff_index_path, notice: 'Staff member was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @staff.update(role_id: nil)
    redirect_to schools_staff_index_path, notice: 'Staff member was successfully removed.'
  end

  private

  def set_staff
    @staff = current_school.users.find(params[:id])
  end

  def staff_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :phone_number,
      :role_id, :qualification, :experience, :specialization,
      :date_of_birth, :gender, :address
    )
  end

  def load_roles
    @roles = current_school.roles.active
  end

  def check_feature_enabled
    unless current_school.feature_enabled?('staff_management')
      redirect_to root_path, alert: 'Staff management feature is not enabled for your school.'
    end
  end
end 
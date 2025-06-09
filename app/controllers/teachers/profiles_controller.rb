module Teachers
  class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher

    def show
    end

    def edit
    end

    def update
      if @teacher.update(teacher_params)
        redirect_to teachers_profile_path, notice: 'Profile was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_teacher
      @teacher = current_user.teacher
    end

    def teacher_params
      params.require(:teacher).permit(:first_name, :last_name, :email, :phone_number, :qualification, :experience, :specialization)
    end
  end
end 
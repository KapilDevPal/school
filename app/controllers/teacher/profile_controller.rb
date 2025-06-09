module Teacher
  class ProfileController < ApplicationController
    before_action :authenticate_user!
    before_action :set_teacher
    before_action :authorize_teacher

    def show
    end

    def edit
    end

    def update
      if @teacher.update(teacher_params)
        redirect_to teacher_profile_path(@teacher), notice: 'Profile was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    def authorize_teacher
      unless current_user.teacher == @teacher
        redirect_to teacher_root_path, alert: 'You are not authorized to access this page.'
      end
    end

    def teacher_params
      params.require(:teacher).permit(
        :first_name,
        :last_name,
        :email,
        :phone_number,
        :qualification,
        :experience_years,
        :specialization,
        :bio
      )
    end
  end
end 
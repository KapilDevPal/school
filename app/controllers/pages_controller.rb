class PagesController < ApplicationController
  skip_before_action :authenticate_user_or_school_owner!, only: [:landing, :about]

  def landing
    if user_signed_in?
      case current_user.role
      when 'teacher'
        redirect_to teachers_root_path
      when 'student'
        redirect_to student_root_path
      when 'admin'
        redirect_to admin_root_path
      end
    elsif school_owner_signed_in?
      redirect_to schools_root_path
    end
  end

  def about
  end

  def contact
  end
end 
class PagesController < ApplicationController
  skip_before_action :authenticate_user_or_school_owner!, only: [:landing]

  def landing
    if user_signed_in?
      redirect_to dashboard_path
    elsif school_owner_signed_in?
      redirect_to school_owner_path(current_school_owner)
    end
  end
end 
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user_or_school_owner!, unless: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_school, :feature_enabled?, :current_school_owner

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number])
  end

  def authenticate_user_or_school_owner!
    return if devise_controller?
    
    if controller_path.start_with?('schools/')
      unless current_school_owner
        redirect_to new_school_owner_session_path, alert: 'You need to sign in or sign up before continuing.'
        return
      end
      
      unless current_school_owner.schools.include?(current_school)
        redirect_to school_owner_path(current_school_owner), alert: 'Please select a school to access this page.'
        return
      end
    elsif controller_path.start_with?('admin/')
      authenticate_user!
    elsif controller_path.start_with?('teacher/')
      authenticate_user!
      unless current_user.teacher?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
        return
      end
    elsif controller_path.start_with?('student/')
      authenticate_user!
      unless current_user.student?
        redirect_to root_path, alert: 'You do not have permission to access this page.'
        return
      end
    else
      unless user_signed_in? || school_owner_signed_in?
        if request.path.start_with?('/schools/')
          redirect_to new_school_owner_session_path, alert: 'Please sign in as a school owner to access this page.'
        else
          redirect_to new_user_session_path, alert: 'Please sign in to access this page.'
        end
        return
      end
    end
  end

  def current_school
    return nil unless current_school_owner
    @current_school ||= if session[:current_school_id]
      current_school_owner.schools.find_by(id: session[:current_school_id])
    else
      current_school_owner.schools.first
    end
  end

  def current_school_owner
    @current_school_owner ||= warden.authenticate(scope: :school_owner)
  end

  def feature_enabled?(feature)
    current_school&.features_enabled&.include?(feature.to_s)
  end
end

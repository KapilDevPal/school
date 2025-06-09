class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  def new_teacher
    self.resource = resource_class.new(sign_in_params)
    render :new_teacher
  end

  def new_student
    self.resource = resource_class.new(sign_in_params)
    render :new_student
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:role])
  end

  def after_sign_in_path_for(resource)
    case resource.role
    when 'teacher'
      teachers_root_path
    when 'student'
      student_root_path
    else
      super
    end
  end

  private

  def auth_options
    { scope: :user, recall: "#{controller_path}#new" }
  end
end 
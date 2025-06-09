class SchoolOwners::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.schools.empty?
      school_owner_path(resource, select_school: true)
    else
      school_owner_path(resource)
    end
  end
end 
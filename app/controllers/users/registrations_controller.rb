class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_up_path_for(resource)
    projects_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_type, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_type, :profile_image])
  end
end

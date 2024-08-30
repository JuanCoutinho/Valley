class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile_image])
  end
end
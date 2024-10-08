class UsersController < ApplicationController # rubocop:disable Style/Documentation
  before_action :configure_permitted_parameters, if: :devise_controller?

  def perfil
    @user = current_user
  end

  def after_sign_in_path_for
    projects_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile_image])
  end
end

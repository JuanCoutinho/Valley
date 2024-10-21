module Users
  class RegistrationsController < Devise::RegistrationsController # rubocop:disable Style/Documentation
  before_action :configure_permitted_parameters, if: :devise_controller? # rubocop:disable Layout/IndentationWidth

    def after_sign_up_path_for(_resource) # rubocop:disable Layout/IndentationConsistency
      projects_path
    end

    def after_sign_in_path_for(_resource) # rubocop:disable Layout/IndentationConsistency
      projects_path
    end

    protected

  def configure_permitted_parameters # rubocop:disable Layout/IndentationWidth
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_type, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_type, :profile_image, :description])
  end
  end
end

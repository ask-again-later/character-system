class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :attended_info_session])
    devise_parameter_sanitizer.permit(:edit, keys: [:name, :attended_info_session])
  end

  def requires_storyteller
    unless user_signed_in? and current_user.is_storyteller
      redirect_to root_path
    end
  end

  def requires_admin
    unless user_signed_in? and current_user.is_admin
      redirect_to root_path
    end
  end
end

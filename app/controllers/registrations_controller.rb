class RegistrationsController < Devise::RegistrationsController
  protected

  def after_inactive_sign_up_path_for(resource)
    flash[:alert] = I18n.t 'devise.confirmations.send_instructions'
  end
end

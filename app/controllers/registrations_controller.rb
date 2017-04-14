class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    flash[:alert] = i18n.t('en.devise.confirmations.send_instructions')
    redirect_to new_user_session_path
  end

  def after_inactive_sign_up_path_for(resource)
    flash[:alert] = i18n.t('en.devise.confirmations.send_instructions')
    redirect_to new_user_session_path
  end
end

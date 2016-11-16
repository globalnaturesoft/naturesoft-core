module Naturesoft
  class Users::RegistrationsController  < Devise::RegistrationsController
    layout :set_layout
    
    private
    def set_layout
      if session[:current_view] == 'frontend'
        "naturesoft/frontend"
      else
        "naturesoft/login"
      end
    end
    
    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :user_group_id)
    end
    
    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :user_group_id)
    end
    
    def after_inactive_sign_up_path_for(resource_or_scope)
      if session[:current_view] == 'frontend'
        naturesoft.confirmable_email_path
      elsif session[:current_view] == 'backend'
        naturesoft.backend_path
      end
    end
  end
end
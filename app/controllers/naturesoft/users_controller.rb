module Naturesoft
  class UsersController < FrontendController
    def login
    end
    
    def register
    end
    
    def forgot_password
    end
    
    def reset_password
    end
    
    def confirmable_email
    end
    
    # PATCH/PUT /users/1
    def update
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
      
      if @user.update(user_params)
        redirect_to backend_area_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
    
    def admin_area
      @user = current_user
      
      if params[:user].present?
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
        
        if @user.update(user_params)
          redirect_to admin_area_path, notice: t('user_profile_updated')
        end
      end
    end
    
    def update_newsletter
      @user = current_user
      
      if params[:user].present?
        if @user.update(user_params)
          redirect_to settings_path, notice: t('user_profile_updated')
        end
      end
    end
    
    def order_history
    end
    
    def wish_list
    end
    
    def settings
      @user = current_user
      
      # check current password is valid
      if params[:user].present? and !@user.valid_password?(params[:user][:current_password])
        redirect_to naturesoft.settings_path, alert: t('current_password_is_invalid')
        return
      end
      
      if params[:user].present?
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
        
        if @user.update(user_params)
          redirect_to login_path, notice: t('devise.passwords.updated_not_active')
        end
      end
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = Naturesoft::User.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def user_params
        params.fetch(:user, {}).permit(:newsletter_enabled, :first_name, :last_name, :email, :phone, :address, :birthdate, :zip, :image, :password, :password_confirmation, :user_group_id)
      end
  end
end
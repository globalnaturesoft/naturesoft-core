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
    
    def backend_area
      @user = current_user
      
      if params[:user].present?
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
        
        if @user.update(user_params)
          redirect_to backend_area_path, notice: 'Profile was successfully updated.'
        end
      end
    end
    
    def order_history
    end
    
    def wish_list
    end
    
    def settings
      @user = current_user
      
      if params[:user].present?
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
        
        if @user.update(user_params)
          redirect_to login_path, notice: 'Password was successfully updated.'
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
        params.fetch(:user, {}).permit(:first_name, :last_name, :email, :phone, :address, :birthdate, :zip, :image, :password, :password_confirmation, :user_group_id)
      end
  end
end
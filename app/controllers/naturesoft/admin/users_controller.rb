module Naturesoft::Admin
  class UsersController < Naturesoft::Admin::AdminController
    before_action :set_user, only: [:edit, :update]
    before_action :default_breadcrumb
        
    # add top breadcrumb
    def default_breadcrumb
      add_breadcrumb "User", naturesoft.admin_users_path
      add_breadcrumb "Users", naturesoft.admin_users_path
    end
    
    def index
      @users = Naturesoft::User.search(params).paginate(:page => params[:page], :per_page => 10)
    end
    
    # GET /slides/new
    def new
      @user = Naturesoft::User.new
      add_breadcrumb "New user", naturesoft.new_admin_user_path
    end

    # POST /slides
    def create
      @user = Naturesoft::User.new(user_params)

      if @user.save
        redirect_to admin_users_path, notice: 'User was successfully created.'
      else
        render :new
      end
    end
    
    # GET /users/1/edit
    def edit
      add_breadcrumb @user.email, naturesoft.new_admin_user_path
      add_breadcrumb "Edit"
    end

    # PATCH/PUT /users/1
    def update
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
      
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
    
    # GET/PUT /users/admin/account
    def account
      add_breadcrumb "My account"
      
      @user = current_user
      
      if params[:user].present?
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
        
        if @user.update(user_params)
          redirect_to account_admin_users_path, notice: 'Account was successfully updated.'
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
        params.fetch(:user, {}).permit(:first_name, :last_name, :email, :image, :password, :password_confirmation, :user_group_id)
      end
  end
end
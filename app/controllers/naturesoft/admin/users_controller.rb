module Naturesoft::Admin
  class UsersController < Naturesoft::Admin::AdminController
    before_filter :variable_controller
        
    def variable_controller
      @title_1 = "User"
      @title_2 = "Users"
      @link = naturesoft.admin_users_path
    end
    
    def index
      @users = Naturesoft::User.ordered.paginate(:page => params[:page], :per_page => 1)
    end
  end
end
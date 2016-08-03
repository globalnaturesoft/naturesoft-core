module Naturesoft::Admin
  class UsersController < Naturesoft::Admin::AdminController
    before_action :default_breadcrumb
        
    # add top breadcrumb
    def default_breadcrumb
      add_breadcrumb "User", naturesoft.admin_users_path
      add_breadcrumb "Users", naturesoft.admin_users_path
    end
    
    def index
      @users = Naturesoft::User.ordered.paginate(:page => params[:page], :per_page => 1)
    end
  end
end
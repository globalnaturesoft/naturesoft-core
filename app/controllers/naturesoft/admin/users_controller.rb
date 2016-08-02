module Naturesoft::Admin
  class UsersController < Naturesoft::Admin::AdminController
    def index
      @users = Naturesoft::User.ordered.paginate(:page => params[:page], :per_page => 10)
    end
  end
end
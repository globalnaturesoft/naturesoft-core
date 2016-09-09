module Naturesoft
  module Admin
    class UserGroupsController < Naturesoft::Admin::AdminController
      before_action :set_user_group, only: [:show, :edit, :update, :destroy]
      before_action :default_breadcrumb
        
      # add top breadcrumb
      def default_breadcrumb
        add_breadcrumb "User", naturesoft.admin_users_path
        add_breadcrumb "User Groups", naturesoft.admin_user_groups_path
      end
  
      # GET /user_groups
      def index
        @user_groups = UserGroup.all.ordered.paginate(:page => params[:page], :per_page => 10)
      end
  
      # GET /user_groups/1
      def show
      end
  
      # GET /user_groups/new
      def new
        @user_group = UserGroup.new
        add_breadcrumb "New User Group", nil,  class: "active"
      end
  
      # GET /user_groups/1/edit
      def edit
        add_breadcrumb "Edit User Group", nil,  class: "active"
      end
  
      # POST /user_groups
      def create
        @user_group = UserGroup.new(user_group_params)
  
        if @user_group.save
          redirect_to edit_admin_user_group_path(@user_group.id), notice: 'User group was successfully created.'
        else
          render :new
        end
      end
  
      # PATCH/PUT /user_groups/1
      def update
        if @user_group.update(user_group_params)
          redirect_to edit_admin_user_group_path(@user_group.id), notice: 'User group was successfully updated.'
        else
          render :edit
        end
      end
  
      # DELETE /user_groups/1
      def destroy
        @user_group.destroy
        render text: 'User group was successfully destroyed.'
      end
      
      # GET /user_groups/select2
      def select2
        render json: UserGroup.select2(params)
      end
  
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user_group
          @user_group = UserGroup.find(params[:id])
        end
  
        # Only allow a trusted parameter "white list" through.
        def user_group_params
          params.fetch(:user_group, {}).permit(:name, :description)
        end
    end
  end
end

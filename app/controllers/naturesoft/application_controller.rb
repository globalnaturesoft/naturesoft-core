module Naturesoft
  class ApplicationController < ActionController::Base
    private
      def after_sign_in_path_for(resource_or_scope)
        if session[:current_view] == 'frontend'
          "/"
        elsif session[:current_view] == 'backend'
          naturesoft.admin_path
        end
      end
      #
      #def after_sign_up_path_for(resource_or_scope)
      #  naturesoft.new_user_session_path
      #end
  end
end

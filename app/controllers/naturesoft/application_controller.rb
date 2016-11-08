module Naturesoft
  class ApplicationController < ActionController::Base

    rescue_from	CanCan::AccessDenied do |exception|
      render :file => "static/403.html",
        :status => 403,
        :layout	=> false
    end
    
    def current_ability
      @current_ability ||= AccountAbility.new(current_account)
    end
    
    private      
      def after_sign_in_path_for(resource_or_scope)
        if session[:current_view] == 'frontend'
          naturesoft.backend_area_path
        elsif session[:current_view] == 'backend'
          naturesoft.backend_path
        end
      end
  end
end

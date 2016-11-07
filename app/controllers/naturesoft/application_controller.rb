module Naturesoft
  class ApplicationController < ActionController::Base
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

module Naturesoft::Admin
    class AdminController < Naturesoft::ApplicationController
        before_action :authenticate_user!
        layout :set_layout
        
        def index
		end
		
		private
		def set_layout		  
		  return "naturesoft/blank" if params[:ajax]
		  "naturesoft/backend"
		end
    end
end
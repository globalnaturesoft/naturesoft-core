module Naturesoft
    class Users::SessionsController < Devise::SessionsController
        layout :set_layout
        
        private
        def set_layout
            if session[:current_view] == 'frontend'
                "naturesoft/frontend"
            else
                "naturesoft/login"
            end
        end
    end
end
module Naturesoft
  class FrontendController < Naturesoft::ApplicationController
    layout 'naturesoft/frontend'
    before_action :set_view
    
    private
      def set_view
        session[:current_view] = "frontend"
      end
  end
end

module Naturesoft::Admin
    class DashboardController < Naturesoft::Admin::AdminController
        before_action :default_breadcrumb
        
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Dashboard", nil
        end
        
        def index
            
        end
    end
end
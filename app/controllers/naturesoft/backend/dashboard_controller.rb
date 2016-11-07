module Naturesoft::Backend
    class DashboardController < Naturesoft::Backend::BackendController
        before_action :default_breadcrumb
        
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Dashboard", nil
        end
        
        def index
            
        end
    end
end
require_dependency "naturesoft/application_controller"

module Naturesoft::Admin
  class OptionsController < Naturesoft::Admin::AdminController
    before_action :default_breadcrumb
      
    # add top breadcrumb
    def default_breadcrumb
      add_breadcrumb "Setting", nil
    end
    
    # Setting default page
    def index
      add_breadcrumb "Settings", nil
      options = {}
      
      # save options
      if params[:options].present?
        # save to database
        Naturesoft::Option.update(JSON.parse(params[:options].to_json))
        
        redirect_to :back
      end
    end
  end
end

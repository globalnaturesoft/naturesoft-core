require_dependency "naturesoft/application_controller"

module Naturesoft::Backend
  class OptionsController < Naturesoft::Backend::BackendController
    before_action :default_breadcrumb
      
    # add top breadcrumb
    def default_breadcrumb
      add_breadcrumb "Setting", nil
    end
    
    # Setting default page
    def index
      add_breadcrumb params[:engine].capitalize, nil      
      @options = Naturesoft::Option.options(params[:engine])
      
      # save options
      if params[:options].present?
        # save to database
        Naturesoft::Option.update(JSON.parse(params[:options].to_json))
        
        redirect_to naturesoft.backend_options_path(engine: params[:engine]), notice: 'Settings were successfully updated.'
      end
    end
  end
end

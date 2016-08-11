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
        puts "ssssssswwwwwwwwwwwwwwwwwwwwwwsssss"
        puts params[:options]
        params[:options].each do |row|
          options[row] = {}
          params[:options][row].each do |child|
            options[row][child] = params[:options][row][child]
          end
        end
        # save to database
        Naturesoft::Option.update_options(options)
        puts "ddddddddddddddddddddddd"
        puts options
        
        redirect_to :back
      end
    end
  end
end

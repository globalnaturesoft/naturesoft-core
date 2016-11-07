module Naturesoft::Backend
    class BackendController < Naturesoft::ApplicationController
		before_action :set_view
		before_action :authenticate_user!
		layout :set_layout
		
		def index
		end
        
    def custom_sort
			# sorting
			data = JSON.parse(params[:sort]);
			orders = []
			ids = []
			data.each do |row|
			  orders << row[0].to_i
			  ids << row[1].to_i
			end
			orders = orders.sort
			
			ids.each_with_index do |id,index|
			  eval(params[:class]).find(id).update_column(:custom_order, orders[index])
			end
			
			render plain: "Custom order updated"
		end
		
		private
			def set_view
				session[:current_view] = "backend"
			end
			
			def set_layout		  
			  return "naturesoft/blank" if params[:ajax]
			  "naturesoft/backend"
			end			
    end
end
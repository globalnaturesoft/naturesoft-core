require_dependency "naturesoft/application_controller"

module Naturesoft::Admin
  class NsmodulesController < Naturesoft::Admin::AdminController
    before_action :set_nsmodule, only: [:show, :edit, :update, :destroy]

    # GET /nsmodules
    def index
      @nsmodules = Naturesoft::Nsmodule.search(params).paginate(:page => params[:page], :per_page => 20)
    end

    # GET /nsmodules/1
    def show
    end

    # GET /nsmodules/new
    def new
      @nsmodule = Naturesoft::Nsmodule.new
    end

    # GET /nsmodules/1/edit
    def edit
    end

    # POST /nsmodules
    def create
      @nsmodule = Naturesoft::Nsmodule.new(nsmodule_params)
      @nsmodule.options = params[:options].to_json
      @nsmodule.user = current_user

      if @nsmodule.save
        redirect_to naturesoft.edit_admin_nsmodule_path(@nsmodule.id), notice: 'Nsmodule was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /nsmodules/1
    def update
      @nsmodule.options = params[:options].to_json
      
      if @nsmodule.update(nsmodule_params)
        redirect_to naturesoft.edit_admin_nsmodule_path(@nsmodule.id), notice: 'Nsmodule was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /nsmodules/1
    def destroy
      @nsmodule.destroy
      render text: 'Nsmodule was successfully destroyed.'
    end
    
    # DELETE /articles/delete?ids=1,2,3
    def delete
      @nsmodules = Naturesoft::Nsmodule.where(id: params[:ids].split(","))
      @nsmodules.destroy_all
      render text: 'Module(s) was successfully destroyed.'
    end
    
    # GET /nsmodules/form
    def options
      @nsmodule = params[:id].present? ? Naturesoft::Nsmodule.find(params[:id]) : Naturesoft::Nsmodule.new
      @nsmodule.module = params[:type]
      @options = @nsmodule.get_options
      
      render layout: nil
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_nsmodule
        @nsmodule = Naturesoft::Nsmodule.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def nsmodule_params
        params.fetch(:nsmodule, {}).permit(:name, :module, :position)
      end
  end
end

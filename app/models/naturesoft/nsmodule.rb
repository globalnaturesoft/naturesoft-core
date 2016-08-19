module Naturesoft
  class Nsmodule < ApplicationRecord
    belongs_to :user
    
    validates :name, :module, :options, :position, presence: true
    
    @core_positions = {
      "dashboard-left" => nil,
      "dashboard-right" => nil,
    }
    
    #Filter, Sort
    def self.search(params)
      records = self.all
      
      #Search keyword filter
      if params[:keyword].present?
        params[:keyword].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_nsmodules.name,' ')) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_nsmodules.name"
      sort_orders = params[:sort_orders].present? ? params[:sort_orders] : "asc"
      records = records.order("#{sort_by} #{sort_orders}")
      
      return records
    end
    
    # get modules from engines
    def self.modules
      modules = {}
      Dir.glob(Rails.root.join('engines').to_s + "/*") do |d|
        eg = d.split(/[\/\\]/).last
        
        if eval("@#{eg}").present?
          modules[eg] = eval("@#{eg}")
        end
      end
      modules
    end
    
    # modules select options
    def self.modulesSelectOptions
      options = []
      self.modules.each do |m|
        opts = []
        m[1].each do |mm|
          opts << [mm[1]["label"], m[0]+"::"+mm[0]]
        end
        options << [m[0], opts]
      end
      options
    end
    
    # get options by category
    def get_options
      engine = self.engine_name
      mod = self.module_name
        
      # Get default options
      result = Nsmodule.get_default(engine, mod)
      
      if options.present?
        result = JSON.parse(options)
        #saved_options.each do |row|
        #  result[row[0]] = row[1]
        #end
      end
      
      return result
    end
    
    # get default values from model
    def self.get_default(engine, mod)
      options = eval("@#{engine}")[mod]["options"]
    end
    
    # get all positions
    def self.positions
      positions = []
      Dir.glob(Rails.root.join('engines').to_s + "/*") do |d|
        eg = d.split(/[\/\\]/).last
        
        if eval("@#{eg}_positions").present?
          eval("@#{eg}_positions").each do |row|
            positions << "#{eg}::" + row[0]
          end
        end
      end
      positions
    end
    
    # get modules by position
    def self.get_by_position(pos)
      self.where(position: pos)
    end
    
    # get engine name
    def engine_name
      self.module.split("::")[0]
    end
    
    # get module name
    def module_name
      self.module.split("::")[1]
    end
  end
end

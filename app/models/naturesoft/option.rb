module Naturesoft
  class Option < ApplicationRecord
    
    @core = {
      "site_info" => {
        "name" => "",
        "address" => "",
        "email_1" => "",
        "email_2" => "",
        "phone_1" => "",
        "phone_2" => "",
        "hotline_1" => "",
        "hotline_2" => "",
        "fax" => "",
        "head_office" => "",
        "branch_office" => "",
        "date_of_establishment" => "",
        "charter_capital" => "",
        "certificate_of_business_registration_no" => "",
        "place_of_issue" => "",
        "date_of_issue" => "",
      }
    }
    
    # update options from hash
    def self.update(options)
      options.each do |row|
        cat = row[0].to_s
        
        # Get default config
        defaults = self.get_default(cat)
        
        row[1].each do |child|
          name = child[0].to_s
          value = child[1].to_json
          
          # check if key in default config
          if defaults[cat].key?(name)
            exist = Option.where(category: cat).where(name: name).first
            if exist.present?
              exist.update_attribute(:value, value)
            else
              Option.create(category: cat, name: name, value: value)
            end
          end
        end
      end
    end
    
    # get options by category
    def self.options(cat)
      # Get default options
      options = self.get_default(cat)
      
      # Get saved options
      saved_options = {cat => {}}
      Option.where(category: cat).each do |o|
        saved_options[cat][o.name] = JSON.parse(o.value)
      end
      
      # merge default ans saved options
      options.each do |row|
        row[1].each do |o|
          options[cat][o[0]] = saved_options[cat][o[0]] if saved_options[cat].key?(o[0])
        end        
      end
      
      return options
    end
    
    def self.get_default(cat)
      {cat => eval("@#{cat}")}
    end
    
    def self.get(cat, name)
      option = Option.where(category: cat).where(name: name).first
      if !option.nil?
        return JSON.parse(option.value)
      else
        options = self.get_default(cat)
        return options[cat][name]
      end
    end
    
    # Get all engines with options
    def self.engines
      engines = []
      Dir.glob(Rails.root.join('engines').to_s + "/*") do |d|
        eg = d.split(/[\/\\]/).last
        engines << eg if eval("@#{eg}").present?
      end
      engines.sort{|x,y| x<=>y}
    end
    
  end
end

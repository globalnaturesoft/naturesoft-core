module Naturesoft
  class Option < ApplicationRecord
    
    @core = {
      "site_info_name" => "",
      "site_info_address" => "",
      "site_info_email_1" => "",
      "site_info_email_2" => "",
      "site_info_phone_1" => "",
      "site_info_phone_2" => "",
      "site_info_hotline_1" => "",
      "site_info_hotline_2" => "",
      "site_info_fax" => "",
      "site_info_head_office" => "",
      "site_info_branch_office" => "",
      "site_info_date_of_establishment" => "",
      "site_info_charter_capital" => "",
      "site_info_certificate_of_business_registration_no" => "",
      "site_info_place_of_issue" => "",
      "site_info_date_of_issue" => "",
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

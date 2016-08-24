require 'active_support/concern'

#module Naturesoft
  module CustomOrder
    extend ActiveSupport::Concern
    
    included do
      after_create :init_custom_order
    end
    
    module ClassMethods
      def self.reset_custom_order
        self.order("created_at").each_with_index do |item,index|
          item.update_column(:custom_order, index)
        end
      end
    end
    
    def init_custom_order
      self.update_column(:custom_order, Nsmodule.maximum("custom_order")+1)
    end
  end
#end
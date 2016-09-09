module Naturesoft
  class UserGroup < ApplicationRecord
    # additional validate
    validates :name, presence: true
    scope :ordered, -> { order('created_at desc') }
    
    # data for select2 ajax
    def self.select2(params)
			items = self.all
			if params[:excluded].present?
				items = items.where.not(id: params[:excluded].split(","))
			end
			options = [{"id" => "", "text" => "none"}]
			options += items.map { |c| {"id" => c.id, "text" => c.name} }
			result = {"items" => options}
		end
    
  end
end

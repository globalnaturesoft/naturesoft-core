module Naturesoft
  class Option < ApplicationRecord
    def self.update_options(options)
      options.each do |row|
        cat = row[0]
        row[1].each do |child|
          puts child[1].to_json
          value = child[1].to_json
          exist = Option.where(category: cat).where(name: child[0]).first
          if exist.present?
            exist.update_attribute(:value, value)
          else
            Option.create(category: cat, name: child[0], value: value)
          end
        end
      end
    end
  end
end

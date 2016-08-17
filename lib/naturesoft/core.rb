require 'autoprefixer-rails'
require 'devise'
require 'will_paginate'
require 'will_paginate-bootstrap'
require 'breadcrumbs_on_rails'
require 'carrierwave'
require 'mini_magick'
require 'sixarm_ruby_unaccent'

module Naturesoft
  module Core
    def self.available?(engine_name)
	  Object.const_defined?("Naturesoft::#{engine_name.to_s.camelize}")
    end
  end
end

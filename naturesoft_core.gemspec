$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "naturesoft/core/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "naturesoft_core"
  s.version     = Naturesoft::Core::VERSION
  s.authors     = ["Luan Pham",
                  "Son Nguyen",
                  "Hung Nguyen"]
  s.email       = ["luanpm@hoangkhang.com.vn",
                  "sonnn@hoangkhang.com.vn",
                  "hungtn@hoangkhang.com.vn"]
  s.homepage    = "http://globalnaturesoft.com/"
  s.summary     = "Core features of Global Naturesoft."
  s.description = "Core features of Global Naturesoft."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0"
  s.add_dependency 'autoprefixer-rails', "~> 5.1.5"
  s.add_dependency 'devise', '~> 4.2.0'
  s.add_dependency 'will_paginate'
  s.add_dependency 'will_paginate-bootstrap'
  s.add_dependency 'breadcrumbs_on_rails'
  
end

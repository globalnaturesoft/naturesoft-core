module Naturesoft
  module Core
    class Engine < ::Rails::Engine
      
      isolate_namespace Naturesoft
      
      paths["app/views"] << "app/views/naturesoft"
      
      initializer :append_migrations do |app|
        unless app.root.to_s.match(root.to_s)
          config.paths["db/migrate"].expanded.each do |p|
            app.config.paths["db/migrate"] << p
          end
        end
      end
      
      #config.to_prepare do
      #  Dir.glob(Engine.root.join("app", "models", "concerns", "**", "*.rb")) do |c|
      #    Rails.configuration.cache_classes ? require(c) : load(c)
      #  end
      #end
      
      
      initializer "static assets" do |app|
        app.middleware.use ::ActionDispatch::Static, "#{root}/public"
      end
      
			# config.autoload_paths << File.expand_path("../lib/some/path", __FILE__)
	  
    end
  end
end

module AppVersion
	module Generators
		class UninstallGenerator < Rails::Generators::Base

			source_paths << File.expand_path('../../../../source_files', __FILE__) 

			def delete_version_erb
				FileUtils.rm( Rails.root.join("lib", "templates", "version.yml.erb") )
			end

			def delete_version_yml
				FileUtils.rm( Rails.root.join("config", "version.yml") )
			end

			def delete_capistrano_task
				FileUtils.rm( Rails.root.join("lib", "capistrano", "tasks", "app_version.cap") )
			end

			def delete_app_version_initializer
				FileUtils.rm( Rails.root.join("config", "initializers", "app_version.rb") )
			end

		end
	end
end
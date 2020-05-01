module AppVersion
	module Generators
		class InstallGenerator < Rails::Generators::Base

			source_paths << File.expand_path('../../../../source_files', __FILE__) 

			def copy_version_erb
				targetDir = Rails.root.join("lib", "templates")
				FileUtils.mkdir( targetDir, :verbose => true) unless File.exists?(targetDir)

				copy_file "version.yml.erb", Rails.root.join("lib", "templates", "version.yml.erb") 
			end

			def copy_version_yml
				copy_file "version.yml", Rails.root.join("config", "version.yml") 
			end

			def copy_capistrano_task
				copy_file "app_version.cap", Rails.root.join("lib", "capistrano", "tasks", "app_version.cap") 
			end

			def copy_app_version_initializer
				copy_file "app_version_initializer.rb", Rails.root.join("config", "initializers", "app_version.rb") 
			end

		end
	end
end
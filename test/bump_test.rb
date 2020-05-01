require 'test_helper'
require 'byebug'

# class App::Version::Test < ActiveSupport::TestCase
class App::Version::BumpTest < ActiveSupport::TestCase

	load FileUtils.pwd << '/lib/tasks/app_version_tasks.rake'

	def setup
		source = FileUtils.pwd << '/test/test_source_files/'
		FileUtils.cp(source+'test_version.yml.erb', Rails.root.join( "lib", "templates", "version.yml.erb") )
	end

	def teardown

	end

	
	def test_bump_without_args
		Dir.chdir(Rails.root) do
			`Rake app:version:bump`
		end
	
		assert_equal  "7", App::Version.load( Rails.root.join('config/version.yml') ).patch
  	end

	
	def test_bump_patch
		Dir.chdir(Rails.root) do
			`Rake app:version:bump:patch`
		end

		assert_equal  "7", App::Version.load( Rails.root.join('config/version.yml') ).patch
  	end


	def test_bump_minor
		Dir.chdir(Rails.root) do
			`Rake app:version:bump:minor`
		end

		assert_equal  "6", App::Version.load( Rails.root.join('config/version.yml') ).minor
		assert_equal  "0", App::Version.load( Rails.root.join('config/version.yml') ).patch
  	end

	def test_bump_major
		Dir.chdir(Rails.root) do
			`Rake app:version:bump:major`
		end
		
		assert_equal  "5", App::Version.load( Rails.root.join('config/version.yml') ).major
		assert_equal  "0", App::Version.load( Rails.root.join('config/version.yml') ).patch
		assert_equal  "0", App::Version.load( Rails.root.join('config/version.yml') ).minor
  	end
end

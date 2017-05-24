require 'test_helper'
require 'byebug'


class BumpTest < MiniTest::Test

	load FileUtils.pwd << '/lib/tasks/app_version_tasks.rake'

	def setup
		source = FileUtils.pwd << '/lib/app_version/templates/'
		FileUtils.cp(source + 'version_test.yml.erb', Rails.root.join( "lib", "templates", "version.yml.erb") )
	end

	def teardown

	end

	
	def test_bump_without_args
		Dir.chdir(Rails.root) do
			`Rake app:bump`
		end
	
		assert_equal  "7", App::Version.load( Rails.root.join('config/version.yml') ).patch
  	end

	
	def test_bump_patch
		Dir.chdir(Rails.root) do
			`Rake app:bump:patch`
		end

		assert_equal  "7", App::Version.load( Rails.root.join('config/version.yml') ).patch
  	end


	def test_bump_minor
		Dir.chdir(Rails.root) do
			`Rake app:bump:minor`
		end

		assert_equal  "6", App::Version.load( Rails.root.join('config/version.yml') ).minor
		assert_equal  "0", App::Version.load( Rails.root.join('config/version.yml') ).patch
  	end

	def test_bump_major
		Dir.chdir(Rails.root) do
			`Rake app:bump:major`
		end
		
		assert_equal  "5", App::Version.load( Rails.root.join('config/version.yml') ).major
		assert_equal  "0", App::Version.load( Rails.root.join('config/version.yml') ).patch
		assert_equal  "0", App::Version.load( Rails.root.join('config/version.yml') ).minor
  	end
end

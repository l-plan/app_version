## App Version
this is a fork from app_version: https://github.com/mort666/app_version

this gem adds a few rake-tasks tot give the version a bump.

### Install

To install include in your Gemfile and execute bundler install

	gem 'app_version'

then:

rails generate app_version:install

- initializer

- version.yml

- version.yml.erb

- app_version.cap


## initializer
To include the version information into your running application create an initialiser within the config directory of the rails application that includes.

	if defined?(Rails.root.to_s) && File.exists?("#{(Rails.root.to_s)}/config/version.yml")
  		APP_VERSION = App::Version.load "#{(Rails.root.to_s)}/config/version.yml"
	end

This will load a constant called APP_VERSION That includes the version information. This can then be rendered within the application using

	APP_VERSION.to_s

Use this within your application view or helper methods, more detail on other version meta data in the usage section.

## version.yml

## version.yml.erb

## app_version.cap


to remove:

rails generate app_version:uninstall


### Usage

To use, simply place a file in RAILS_ROOT/config called version.yml with the
following format:

  	major:     2
  	minor:     0
  	patch:     1
    meta:      rc.1
  	milestone: 4
  	build:     git-revcount
  	branch:    master
  	committer: coder
  	build_date: 2008-10-27 17:07:59 +0200

If the milestone or patch fields are less than 0 then they will not show up in the version string. The build field can be a build number or one of the following strings: svn, git-hash or git-revcount. If it is a number then that number will be used as the build number, if it is one of the special strings then the plugin will attempt to query the source control system for the build number. The build date field can be a date or the following string: git-revdate.

If you use the special string it will query the source control system and output in YYYY-MM-DD format the commit date of the last revision.

Using 'svn' for the build number will cause the plugin to query Subversion for the current revision number. Since Git doesn't have a numbered revision we have to fake it. 'git-revcount' will count the number of commits to the repository and use that as the build number whereas 'git-hash' will use the first 6 digits of the current HEAD's hash.

The plugin creates a constant `APP_VERSION` that contains the version number of the application. Calling the `to_s` method on APP_VERSION will result in a properly formatted version number.

APP_VERSION also has `major`, `minor`, `patch`, `meta`, `milestone`, `build`,`branch`, `committer`, and `build_date` methods to retrieve the individual components of the version number.

There is a default format and a "semantic versioning" format to use.  The semantic versioning format follows: http://semver.org/ as guidelines.


### Capistrano Usage

When the app_version plugin is installed, it copies a templated edition of the version.yml file into /lib/templates/version.yml.erb, the initial file shows a tag for retrieving the revision count with git. It also displays the branch, retrieved from the current git repo see the comments in the erb file for more nifty tricks.

When you do a cap deploy, there is a capistrano task built-in to the app_version gem, which will render the templated version.yml into the standard location as mentioned above. This happens automatically after the deploy is done.

Both the standard and extended capistrano usage can co-exist in the same project the dynamic rendering of the version.yml only happens when using capistrano to deploy your app.

**Not Confirmed working in this version**

### Rake tasks

This plugin includes a few new rake tasks:

	rake app:render     - will render the erb template into /config/version.yml
    	                  in case you want to have dynamic values updated via a rake task.
        	              Note: certain examples expect the app to be in a git working directory.

	rake app:version    - will output the version number of the current rails
                    	  application.


  rake app:version:bump    - default, will perform bump patch

  rake app:version:bump:patch    - increase version patch with 1

  rake app:version:bump:minor    - increase version minor with 1, set patch to 0

  rake app:version:bump:major    - increase version major with 1, set minor and patch to 0
                        
## License

This plugin is released under the terms of the Ruby license. See
http://www.ruby-lang.org/en/LICENSE.txt.

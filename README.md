## App Version

[![Build Status](https://travis-ci.org/mort666/app_version.png?branch=master)](https://travis-ci.org/mort666/app_version)

This is a simple plugin that makes it easy to manage the version number of your Rails application. The version numbers supported by this plugin look like '2.0.0-rc.1 M4 (600) of branch by coder on 2008-10-27'.

The components of the version number are:

  	2          => major
  	0          => minor
  	0          => patch
    rc.1       => meta information (as defined by Semantic Versioning)
  	M4         => milestone
  	(600)      => build number (usually Subversion revision)
 	branch     => the name of the branch this version is from.
 	coder      => the name of the user that made the release
  	2008-10-27 => the date of the release

Only the major and minor numbers are required. The rest can be omitted and the plugin will attempt to do the right thing.

### Install

To install include in your Gemfile and execute bundler install

	gem 'app_version'

Will then have the rake tasks below available.

To include the version information into your running application create an initialiser within the config directory of the rails application that includes.

	if defined?(Rails.root.to_s) && File.exists?("#{(Rails.root.to_s)}/config/version.yml")
  		APP_VERSION = App::Version.load "#{(Rails.root.to_s)}/config/version.yml"
	end

This will load a constant called APP_VERSION That includes the version information. This can then be rendered within the application using

	APP_VERSION.to_s
	
Use this within your application view or helper methods, more detail on other version meta data in the usage section.

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
  	build_date: 2008-10-27

If the milestone or patch fields are less than 0 then they will not show up in the version string. The build field can be a build number or one of the following strings: svn, git-hash or git-revcount. If it is a number then that number will be used as the build number, if it is one of the special strings then the plugin will attempt to query the source control system for the build number. The build date field can be a date or the following string: git-revdate.

If you use the special string it will query the source control system and output in YYYY-MM-DD format the commit date of the last revision.

Using 'svn' for the build number will cause the plugin to query Subversion for the current revision number. Since Git doesn't have a numbered revision we have to fake it. 'git-revcount' will count the number of commits to the repository and use that as the build number whereas 'git-hash' will use the first 6 digits of the current HEAD's hash.

The plugin creates a constant `APP_VERSION` that contains the version number of the application. Calling the `to_s` method on APP_VERSION will result in a properly formatted version number. 

APP_VERSION also has `major`, `minor`, `patch`, `meta`, `milestone`, `build`,`branch`, `committer`, and `build_date` methods to retrieve the individual components of the version number.

### Capistrano Usage

When the app_version plugin is installed, it copies a templated edition of the version.yml file into /lib/templates/version.yml.erb, the initial file shows a tag for retrieving the revision count with git. It also shows displaying the branch as specified with "set :branch" in your capistrano deploy.rb, see the comments in the erb file for more nifty tricks.

When you do a cap deploy, there is a capistrano recipe built-in to the app_version plugin, which will render the templated version.yml into the standard location as mentioned above. This happens automatically after the deploy is done.

Both the standard and extended capistrano usage can co-exist in the same project the dynamic rendering of the version.yml only happens when using capistrano to deploy your app.

**Not Confirmed working in this version**

### Rake tasks

This plugin includes 4 new rake tasks:

	rake app:install    - will copy the version.yml and version.yml.erb into more user
  	                    accessible locations (/config, and /lib/templates)

	rake app:uninstall  - will remove the files copied in the install task

	rake app:render     - will render the erb template into /config/version.yml
    	                  in case you want to have dynamic values updated via a rake task.
        	              Note: certain examples expect the app to be in a git working directory.

	rake app:version    - will output the version number of the current rails
                    	  application.

## License

This plugin is released under the terms of the Ruby license. See
http://www.ruby-lang.org/en/LICENSE.txt.

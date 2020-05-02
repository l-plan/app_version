## App Version

this is a fork from app_version: https://github.com/mort666/app_version

It now is up to date with todays versions of rails, minitest, capistrano and more. It also adds a few rake-tasks tot give the version a bump. Some tasks are deprecated, and replaced by using generators.


### How it works

The idea is to make your app's version available to your app in a production environment. It should be in sync with your current git-commit, and you should be able to anticipate to this while developing. The idea therefore is to extract some info around deploying, becouse when using capistrano, many git-commands are unavailable in a production environment.

So, there is an engine in development-mode which you can manipulate, manually or executing a rake-task, which will monitor your app's version. On changes, or on deploying (and deploying means using capistrano) it will output the current version to a file, which is loaded in a constant when you restart your server, in development or production.

voila.



## Install

To install include in your Gemfile and execute bundle install

`gem 'app_version' , :git=> 'git@github.com:l-plan/app_version.git'`

then:

`rails generate app_version:install`

this will install the following files:

```
- app_version.rb (initializer)

- version.yml.erb

- version.yml

- app_version.cap
```

### initializer
To include the version information into your running application create an initialiser within the config directory of the rails application that includes.

```
	if defined?(Rails.root.to_s) && File.exists?("#{(Rails.root.to_s)}/config/version.yml")
  		APP_VERSION = App::Version.load "#{(Rails.root.to_s)}/config/version.yml"
	end
```

This will load a constant called APP_VERSION That includes the version information. This can then be rendered within the application using

	APP_VERSION.to_s

Use this within your application view or helper methods, more detail on other version meta data in the usage section.

### version.yml.erb

```
major:        0
minor:        0
patch:        1
# meta:     rc.1
# milestone:  4
build:      <%= `git rev-list HEAD|wc -l`.strip %>
branch:     <%= `git rev-parse --abbrev-ref HEAD`%>
committer:  <%= `git show -s --pretty=format:"%an"` %>
build_date: <%=`git show --date=short --pretty=format:%ai|head -n1`.strip%>

```

the git-output can be replaced by another value. The string in this section, our the output of the erb-tag , will be copied toe version.yml file. For example, build_date can be replaced by Time.now.
The lines which you have commented-out will not be rendered.


### version.yml

```
    major:     2
    minor:     0
    patch:     1
    meta:      rc.1
    milestone: 4
    build:     git-revcount
    branch:    master
    committer: coder
    build_date: 2008-10-27 17:07:59 +0200
```

### app_version.cap

Just before your capistrano-process ends, a new version.yml file will be rendered on yourt local machine, and copied to your release-path. 



## to remove:

rails generate app_version:uninstall


## Usage

To use, simply place a file in RAILS_ROOT/config called version.yml with the
following format: (the gem does this for you)

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

There is a default format and a "semantic versioning" format to use.  The semantic versioning format follows: http://semver.org/ as guidelines.


### Capistrano Usage

When the app_version gem is installed, it copies a templated edition of the version.yml file into /lib/templates/version.yml.erb, the initial file shows a tag for retrieving the revision count with git. It also displays the branch, retrieved from the current git repo. Look at the comments in the erb file for more nifty tricks.

When you do a cap deploy, there is a capistrano task built-in to the app_version gem, which will render the templated version.yml into the standard location as mentioned above. This happens automatically after the deploy is done.

Both the standard and extended capistrano usage can co-exist in the same project the dynamic rendering of the version.yml only happens when using capistrano to deploy your app.


### Rake tasks

This gem includes a few new rake tasks:


| task | Description |
| ----- | ----- |
| rake app:versioning | will output the current /config/version.yml |
| rake app:versioning:render | will render a new  /config/version.yml with the current version.| 
| rake app:versioning:bump | default, will perform bump patch| 
| rake app:versioning:bump:patch | increase version patch with 1| 
| rake app:versioning:bump:minor | increase version minor with 1, set patch to 0| 
| rake app:versioning:bump:major | increase version major with 1, set minor and patch to 0| 

Note: certain tasks expect the app to be in a git working directory.
                        
## License

This plugin is released under the terms of the Ruby license. See
http://www.ruby-lang.org/en/LICENSE.txt.

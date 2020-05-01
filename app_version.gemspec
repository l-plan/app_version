$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "app_version"
  s.version     = "0.3.1"
  s.authors     = ["Scott Curry", "Stephen Kapp", "Phillip Toland", "Rolf vd Geize"]
  s.email       = ["coder.scottcurry.com", "mort666@virus.org", "phil.toland@gmail.com", "rolf@l-plan.nl"]
  s.homepage    = "https://github.com/l-plan/app_version"
  s.summary     = "Rails App Version Gem"
  s.description = "App Version Gem originally App Version Rails Plugin from https://github.com/toland/app_version, updated to run in CI server and with later rails versions as a gem, currently supports Rails 5"

  s.files = Dir["{app,config,db,lib,tasks}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5"
  s.add_development_dependency 'minitest', "> 5.4.0"
  s.add_development_dependency "minitest-reporters"
  s.add_development_dependency "byebug"
end

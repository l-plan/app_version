namespace :app do
  require 'erb'

  desc 'Report the application version.'
  task :version do
    require File.join(File.dirname(__FILE__), "../app_version.rb")
    puts "Application version: " << App::Version.load("#{Rails.root.to_s}/config/version.yml").to_s
  end

  # desc 'Configure for initial install.'
  # task :install do
  #   require File.join(File.dirname(__FILE__), "../install.rb")
  # end

  # desc 'Clean up prior to removal.'
  # task :uninstall do
  #   require File.join(File.dirname(__FILE__), "../uninstall.rb")
  # end

  desc 'Render the version.yml from its template.'
  task :render do
    template = File.read(Rails.root.to_s+ "/lib/templates/version.yml.erb")
    result   = ERB.new(template).result(binding)
    File.open(Rails.root.to_s+ "/config/version.yml", 'w') { |f| f.write(result)}
  end
  

  namespace :version do

    desc "bumps patch if no argument given"
    task bump: ["bump:patch"]

    namespace :bump do 

      str = Proc.new {|line, nr|  nr ||= (line.match(/[0-9]+/).to_s.to_i+1).to_s ; line.sub(/.{3}\z/, nr.tap{|x| x.prepend(' ') while nr.size < 3} )}
      path = Rails.root.join( "lib", "templates", "version.yml.erb" ) 


      desc 'bump patch'
      task :patch do   
        File.write(f = path, File.read(f).sub(/^patch:.+[0-9]/)  {|x| str.call x})
        Rake::Task["app:render"].invoke
      end

      desc 'bump minor'
      task :minor do
        File.write(f = path, File.read(f).sub(/^minor:.+[0-9]/)  {|x| str.call x})
        File.write(f = path, File.read(f).sub(/^patch:.+[0-9]/)  {|x| str.call x, "0"})
        Rake::Task["app:render"].invoke
      end

      desc 'bump major'
      task :major do
        File.write(f = path, File.read(f).sub(/^major:.+[0-9]/)  {|x| str.call x})
        File.write(f = path, File.read(f).sub(/^minor:.+[0-9]/)  {|x| str.call x, "0"})
        File.write(f = path, File.read(f).sub(/^patch:.+[0-9]/)  {|x| str.call x, "0"})
        Rake::Task["app:render"].invoke
      end
    end

    desc "creates a git tag from current version and pushes to git"
    task :tag do 
      
        tag = Proc.new {|x| "v"+[x.major, x.minor, x.patch, x.meta].compact.join('.') }
        # puts tag.call App::Version.load( Rails.root.join('config/version.yml') )
    end

  end

end

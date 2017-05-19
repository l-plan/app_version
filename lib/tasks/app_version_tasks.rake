namespace :app do
  require 'erb'

  desc 'Report the application version.'
  task :version do
    require File.join(File.dirname(__FILE__), "../app_version.rb")
    puts "Application version: " << App::Version.load("#{Rails.root.to_s}/config/version.yml").to_s
  end

  desc 'Configure for initial install.'
  task :install do
    require File.join(File.dirname(__FILE__), "../install.rb")
  end

  desc 'Clean up prior to removal.'
  task :uninstall do
    require File.join(File.dirname(__FILE__), "../uninstall.rb")
  end

  desc 'Render the version.yml from its template.'
  task :render do
    template = File.read(Rails.root.to_s+ "/lib/templates/version.yml.erb")
    result   = ERB.new(template).result(binding)
    File.open(Rails.root.to_s+ "/config/version.yml", 'w') { |f| f.write(result)}
  end

  namespace :bump do 
    desc 'bump patch'
    task :patch do
      # template = File.read(Rails.root.to_s+ "/lib/templates/version.yml.erb")
      # puts "inside...."
      path = Rails.root.join( "lib", "templates", "version.yml.erb" ) 
      # lines.each{|x| p x if x=~ /patch:/}

      str = Proc.new { |nr| ((nr.to_i+1).to_s  ).prepend('     ')[-nr.size, nr.size] }

      File.write(f = path, File.read(f).sub(/patch:.+[0-9]/)  {|x| x+'rolf'})

      # File.open(path, 'r+') do |file|
      #   file.each_line do |line|
      #     # puts line if line =~ /patch:/
      #     line = 'rolf'#(line.sub(/...[0-9]/) {|x| str.call x} )if line =~ /patch:/
          

      #     file.write line # if line =~ /patch:/


      #   end
      # end

    end
  end


end

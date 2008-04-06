require 'rake/gempackagetask'

task :clean => :clobber_package

spec = Gem::Specification.new do |s|
  s.name                  = ActionMessager::NAME
  s.version               = ActionMessager::Version::STRING
  s.platform              = Gem::Platform::RUBY
  s.summary               = 
  s.description           = "Really simple jabber IM notifications."
  s.author                = "James Golick"
  s.email                 = 'james@giraffesoft.ca'
  s.homepage              = 'http://jamesgolick.com/action_messager/'
  
  s.required_ruby_version = '>= 1.8.6'
  
  s.add_dependency        'activesupport',      '>= 2.0.2'
  s.add_dependency        'xmpp4r-simple',      '>= 0.8.7'

  s.files                 = %w(LICENSE README Rakefile) +
                            Dir.glob("{lib,test,tasks}/**/*")
                              
  s.require_path          = "lib"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end

task :tag_warn do
  puts "*" * 40
  puts "Don't forget to tag the release:"
  puts "  git tag -a v#{ActionMessager::Version::STRING}"
  puts "*" * 40
end
task :gem => :tag_warn

task :compile do
end

task :install => [:clobber, :compile, :package] do
  sh "sudo gem install pkg/#{spec.full_name}.gem"
end

task :uninstall => :clobber do
  sh "sudo gem uninstall #{spec.name}"
end

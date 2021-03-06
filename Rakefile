require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "standard_tasks"
  gem.homepage = "http://github.com/peterhoeg/standard_tasks"
  gem.license = "MIT"
  gem.summary = %Q{A set of standard tasks for various clean-up and housekeeping jobs}
  gem.description = gem.summary
  gem.email = "peter@hoeg.com"
  gem.authors = ["Peter Hoeg"]
  gem.add_runtime_dependency 'jsmin', '>= 1.0'
  gem.add_development_dependency 'rspec', '> 2'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "standard_tasks #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# make the tasks implemented in this gem available to itself
import 'lib/standard_tasks/tasks.rb'

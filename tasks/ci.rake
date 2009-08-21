namespace :ci do

  desc 'Run build for Continuous Integration '
  task :build => [ 'src:submodules', :spec ]

  task :default => :build
end

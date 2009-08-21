namespace :db do

  desc "Loads initial database models for the current environment."
  task :populate => :environment do
    Dir[File.join(RAILS_ROOT, 'db', 'fixtures', '*.rb')].sort.each { |fixture| load fixture }
    Dir[File.join(RAILS_ROOT, 'db', 'fixtures', RAILS_ENV, '*.rb')].sort.each { |fixture| load fixture }
  end

  desc 'Recreate empty database'
  task :recreate => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:test:clone"].invoke
  end

  desc 'Recreate empty database and populate with seed data'
  task :rebuild => :environment do
    Rake::Task["db:recreate"].invoke
    Rake::Task["db:populate"].invoke
  end

end

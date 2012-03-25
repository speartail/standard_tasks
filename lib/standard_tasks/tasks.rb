namespace :clean do

  @files= %w[ rb erb haml slim xml scss sass css js coffee ]

  desc 'Remove all.{js,css} generated by running in production mode and backup files'
  task :cruft do
    Dir.glob("public/**/all.{js,css}") { |f| safe_unlink f }
    Dir.glob("**/*.{rb,feature}") { |f| system "sed -i 's/[ \t]\+$//g' #{f}" }
    Dir.glob("**/*~") { |f| safe_unlink f }
  end

  desc 'Trailing whitespace'
  task :white do
    Dir.glob("**/*.@files") { |f| puts "find .- name '*.#{f}' -print0 | xargs -0 sed -i 's/[ \t]\+//g" }
  end

  task :all => [ :cruft, :white ]

end

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
    Rake::Task["db:test:clone"].invoke if RAILS_ENV == "development"
  end

  desc 'Recreate empty database and populate with seed data'
  task :rebuild => :environment do
    Rake::Task["db:recreate"].invoke
    Rake::Task["db:populate"].invoke
  end

end

namespace :doc do
  namespace :diagram do

    format = 'svg'
    common_options = '-i -l'
    old_font = 'font-size:14.00'
    new_font = 'font-size:11.00'

    desc "Generate model diagrams"
    task :models do
      sh "railroady #{common_options} -a -m -M | dot -T#{format} | sed 's/#{old_font}/#{new_font}/g' > doc/models.#{format}"
    end

    desc "Generate controller diagrams"
    task :controllers do
      sh "railroady #{common_options} -C | neato -T#{format} | sed 's/#{old_font}/#{new_font}/g' > doc/controllers.#{format}"
    end
  end

  desc "Create diagrams of models and controllers"
  task :diagrams => %w(diagram:models diagram:controllers)

end

namespace :log do

  desc "Strip colouring escape sequences from log files"
  task :strip => :environment do
    in_file = nil
    out_file = nil
    begin
      envs = %w[ production development test ]
      envs.each do |e|
        in_name = File.join(RAILS_ROOT, 'log', e + '.log')
        if File.exists?(in_name)
          puts "Processing: #{in_name}"
          in_file = File.open(in_name, 'r')
          out_file = File.new(File.join(RAILS_ROOT, 'log', e + '_stripped.log'), 'w')
          while line = in_file.gets
            # non-greedily strip from escape to litteral m
            out_file.puts(line.gsub(/\e.+?m/, ''))
          end
        end
      end
    rescue Exception => e
      puts "Error: #{e.message}"
    ensure
      in_file.close if in_file
      out_file.close if out_file
    end
  end

end

namespace :modules do

  desc 'Init all submodules'
  task :init do
    sh "git submodule init"
    sh "git submodule update"
  end

  desc 'Update the source from all submodules'
  task :update => :init do
    sh "for s in $(git submodule | cut -f3 -d ' ') ; do cd $s ; git pull ; cd ../.. ; done"
  end

end

require 'jsmin'
require 'tempfile'

namespace :package do

  desc 'Package and minify CSS'
  task :css do
    Dir.glob(File.join(RAILS_ROOT, 'public', 'stylesheets', '*.css')) do |css|
      tmpfile = ''
      Tempfile.open(File.basename(css)) do |t|
        tmpfile = t.path
        sh "cat #{css} | csstidy - --silent=true #{tmpfile}"
      end
      sh "mv #{tmpfile} #{css}"
    end
  end

  desc 'Package and minify JavaScript'
  task :js do
    Dir.glob(File.join(RAILS_ROOT, 'public', 'javascripts', '*.js')) do |js|
      tmpfile = ''
      Tempfile.open(File.basename(js)) do |t|
        tmpfile = t.path
        t.puts JSMin.minify(js)
      end
      sh "mv #{tmpfile} #{js}"
    end
  end

  desc "Package and minify CSS/JavaScript"
  task :all => [ 'clean:generated', :css, :js ]
end

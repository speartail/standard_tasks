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

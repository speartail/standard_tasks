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

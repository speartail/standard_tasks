namespace :src do

  desc 'Rebase current branch to master'
  task :rebranch => :environment do
    sh "git rebase master"
  end

  desc 'Push all branches to remote(s)'
  task :push => :environment do
    sh "git push --all"
  end

end

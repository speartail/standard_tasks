namespace :doc do

  desc 'create list of tests in plain text for documentation purposes'
  task :tests do
    Dir.glob(File.join(::Rails.root.to_s, 'spec', 'models', '*_specc.rb')).each do |s|
      system %Q[ egrep "describe| it |share" #{s} > #{File.join(RAILS_ROOT, 'doc', "#{s}.txt")} ]
    end
  end

end

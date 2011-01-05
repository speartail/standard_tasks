require 'standard_tasks'
require 'rails'

module StandardTasks
  class Railtie < Rails::Railtie
    rake_tasks do
      Dir.glob('../tasks/*.rake').each { |r| 
        puts "peter: #{r}"
        load r }
    end
  end
end

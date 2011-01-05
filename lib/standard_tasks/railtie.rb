require 'standard_tasks'
require 'rails'

module StandardTasks
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'standard_tasks/tasks.rb'
    end
  end
end

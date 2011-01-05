module Northwind
  class StandardTasks < Rails::Railtie
    rake_tasks do
      load "tasks/*.rake"
    end
#    initializer "newplugin.initialize" do |app|
      # subscribe to all rails notifications: controllers, AR, etc.
#      ActiveSupport::Notifications.subscribe do |*args|
#        event = ActiveSupport::Notifications::Event.new(*args)
#        puts "Got notification: #{event.inspect}"
#      end
#    end
  end
end

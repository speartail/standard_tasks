module Northwind
  if defined?(Rails)
    class StandardTasks < Rails::Railtie
      rake_tasks do
	Dir.glob('standard_tasks/tasks/*.rake').each { |r| load r }
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
end

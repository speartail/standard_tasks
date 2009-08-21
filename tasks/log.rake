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

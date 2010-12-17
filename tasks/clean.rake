namespace :clean do

  desc 'Remove all.{js,css} generated by running in production mode'
  task :generated do
    Dir.glob("public/**/all.{js,css}") { |f| safe_unlink f }
  end

  desc 'Remove all editor backup files'
  task :backup do
    system "find . -name '*~' -delete"
  end

  task :all => [ :generated, :backup ]

end

namespace :doc do

  namespace :diagram do

    format = 'svg'
    common_options = '-i -l'
    old_font = 'font-size:14.00'
    new_font = 'font-size:11.00'

    desc "Generate model diagrams"
    task :models do
      sh "railroad #{common_options} -a -m -M | dot -T#{format} | sed 's/#{old_font}/#{new_font}/g' > doc/models.#{format}"
    end

    desc "Generate controller diagrams"
    task :controllers do
      sh "railroad #{common_options} -C | neato -T#{format} | sed 's/#{old_font}/#{new_font}/g' > doc/controllers.#{format}"
    end
  end

  desc "Create diagrams of models and controllers"
  task :diagrams => %w(diagram:models diagram:controllers)

end

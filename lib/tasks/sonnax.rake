namespace :s do
  task :repro => 'sonnax:repro'
  
  namespace :db do
    task :pull => 'sonnax:database:pull'
    task :push => 'sonnax:database:push'
  end
  
  namespace :assets do
    task :pull => 'sonnax:assets:pull'
    task :push => 'sonnax:assets:push'
    task :destroy => 'sonnax:assets:destroy'
  end
end

namespace :sonnax do
  desc 'Repro Production setup (shared assets and database)'
  task(:repro) do
    puts 'Building repro from production...'
  end
  
  namespace :database do
    desc 'Pull down the database and replicate locally'
    task(:pull) do
      puts 'Pulling down the database from the server..'
    end
    
    desc 'Pushing the database to the remote server'
    task(:push) do
      puts 'Pushing the database to the remote server'
    end
  end
  
  namespace :assets do
    desc 'Pull the assets from the server'
    task(:pull) do
      puts 'Pulling the assets from the server..'
    end
    
    desc 'Remove shared assets from Paperclip'
    task(:destroy) do
      directories = %w( assets avatars pdfs )
      path = File.join(Rails.root, 'public', 'system')
      
      directories.each do |directory|
        rm_cmd = "rm -rf %s" % [File.join(path, directory)]
        puts "Removing %s..." % [rm_cmd]
        system(rm_cmd)
      end
    end
  end
end
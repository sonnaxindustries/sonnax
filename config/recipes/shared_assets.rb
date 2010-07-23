Capistrano::Configuration.instance.load do
  namespace :push do 
    desc "Pushes the shared assets to the remote machine"
    task :assets do 
      if shared_host
        directories = %w( assets avatars pdfs )
        path = File.join('public', 'system')
        
        all_paths = directories.map { |directory| [File.join(path, directory)] }.join(' ')

        run_cmd = "scp -r %s %s@%s:%s/system/" % [all_paths, user, shared_host, shared_path]

        puts 'Pushing assets to the remote server..'
        puts run_cmd
        run_locally(run_cmd)
      else
        puts "Ummmm. You should define a shared_host variable so I know where to get the files from."
      end  
    end
    
    desc "Dump local database into tmp/, rsync file to remove machine, import into remove development database"
    task :database do 
      #NOTE: We don't have passwords on either DB
      remote_database_yml = "%s/database.yml" % [shared_path]
      puts remote_database_yml
      get(remote_database_yml, "tmp/database.yml")
      
      local_settings = YAML::load_file('config/database.yml')['development']
      remote_settings = YAML::load_file('tmp/database.yml')['development']
      
      dumped_file_name = "development-%s-dump.sql" % [local_settings['database']]
      dumped_local_file_path = "tmp/%s" % [dumped_file_name]
      dumped_remote_file_path = "%s/tmp/%s" % [shared_path, dumped_file_name]
      
      run_local_cmd = "mysqldump -u %s %s > %s && scp -r %s %s@%s:%s/tmp/" % [local_settings['username'], local_settings['database'], dumped_local_file_path, dumped_local_file_path, user, shared_host, shared_path]
      run_remote_cmd = "mysql -u %s %s < %s" % [remote_settings['username'], remote_settings['database'], dumped_remote_file_path]
      
      puts "Backup up the database locally..."
      run_locally(run_local_cmd)
      
      puts "Restoring the database on the remote server..."
      run(run_remote_cmd)
      
      #cleanup
      if File.exists?('tmp/database.yml')
        run_locally('rm tmp/database.yml')
      end
      
      if File.exists?(dumped_local_file_path)
        run_locally("rm #{dumped_local_file_path}")
      end
    end
  end
  
  namespace :update do
    desc "Mirrors the remote shared public directory with your local copy, doesn't download symlinks"
    task :shared_assets do 
      if shared_host
        run_locally("rsync --recursive --times --rsh=ssh --compress --human-readable --progress #{user}@#{shared_host}:#{shared_path}/system/ public/system/")
      else
        puts "Ummmm. You should define a shared_host variable so I know where to get the files from."
      end  
    end
 
    desc "Dump remote production database into tmp/, rsync file to local machine, import into local development database"
    task :database do 
      get("#{shared_path}/database.yml", "tmp/database.yml")

      remote_settings = YAML::load_file("tmp/database.yml")["production"]
      local_settings = YAML::load_file("config/database.yml")["development"]
 
      run "mysqldump -u'#{remote_settings["username"]}' -p'#{remote_settings["password"]}' -h'#{remote_settings["host"]}' '#{remote_settings["database"]}' > #{current_path}/tmp/production-#{remote_settings["database"]}-dump.sql"

      run_locally("rsync --times --rsh=ssh --compress --human-readable --progress #{user}@#{shared_host}:#{current_path}/tmp/production-#{remote_settings["database"]}-dump.sql tmp/production-#{remote_settings["database"]}-dump.sql")
      run_locally("mysql -u#{local_settings["username"]} #{"-p#{local_settings["password"]}" if local_settings["password"]} #{local_settings["database"]} < tmp/production-#{remote_settings["database"]}-dump.sql") 
    end
  end
end
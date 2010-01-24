Capistrano::Configuration.instance.load do
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
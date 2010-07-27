require File.join(File.dirname(__FILE__)) + '/cap_helper'

Capistrano::Configuration.instance.load do  
  namespace :s do
    namespace :db do
      desc "Pull database from remote server and copy into local..."
      task :pull do
        database_manager = DatabaseManager::Pull.new(:user => user, :shared_host => shared_host, :shared_path => shared_path, :current_path => current_path)
        
        puts "Dumping the remote database..."
        puts database_manager.commands.remote.dump
        
        puts "Rsync the backup to the local server.."
        puts database_manager.commands.local.rsync
        
        puts "Importing into local database..."
        puts database_manager.commands.local.import
        
        puts "Cleaning up..."
        puts database_manager.cleanup!
      end
      
      desc "Push local database to remote server and copy into remote..."
      task :push do
        database_manager = DatabaseManager::Push.new(:user => user, :shared_host => shared_host, :shared_path => shared_path, :current_path => current_path)

        puts "Dumping the local database..."
        puts database_manager.commands.local.dump
        
        puts "SCP the backup to the remote server..."
        puts database_manager.commands.remote.scp
        
        puts "Importing into remote database..."
        puts database_manager.commands.remote.import
        
        puts "Cleaning up..."
        puts database_manager.cleanup!
      end
    end
    
    namespace :assets do
      desc 'Pull assets from remote server...'
      task :pull do
        asset_manager = SharedAssetManager::Pull.new(:user => user, :shared_host => shared_host, :shared_path => shared_path)
        
        puts "Pulling assets from the remote server..."
        puts asset_manager.to_s
        #run_locally(asset_manager.cmd)
      end
      
      desc 'Push assets to remote server...'
      task :push do
        asset_manager = SharedAssetManager::Push.new(:user => user, :shared_host => shared_host, :shared_path => shared_path)
        
        puts "Pushing assets to the remote server..."
        puts asset_manager.to_s
        #run_locally(asset_manager.cmd)
      end
      
      namespace :destroy do
        desc 'Destroy assets on the local server...'
        task :local do
          asset_manager = SharedAssetManager::Destroy::Local.new(:user => user, :shared_host => shared_host, :shared_path => shared_path)

          puts "Destroying the assets on the local server..."
          puts asset_manager.to_s
          #run_locally(asset_manager.cmd)
        end
        
        desc 'Destroy assets on the remote server...'
        task :remote do
          asset_manager = SharedAssetManager::Destroy::Remote.new(:user => user, :shared_host => shared_host, :shared_path => shared_path)

          puts "Destroying the assets on the remote server..."
          puts asset_manager.to_s
          #run(asset_manager.cmd)
        end
      end
    end
  end
end
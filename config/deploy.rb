require 'config/recipes/passenger'
require 'config/recipes/shared_assets'
require 'config/recipes/bundler'

set :application, "sonnax"
set :repository, 'git@github.com:nateklaiber/sonnax.git'
set :branch, "master"
set :runner, :passenger

set :deploy_to, "/var/www/rails/#{application}"

set :scm, :git
set :scm_verbose, :true
set :user, 'root'
set :use_sudo, false
set :deploy_via, :remote_cache

set :shared_host, '74.50.59.43'

role :app, '74.50.59.43'
role :web, '74.50.59.43'
role :db, '74.50.59.43', :primary => true

desc "deploy to the theklaibers subdomain"
task :theklaibers do
  set :deploy_to, "/var/www/rails/sonnax"
  set :application, "sonnax"
  set :app, "theklaibers.com"
  set :db, "theklaibers.com"  
end

desc "deploy to the production domain"
task :production do
  set :deploy_to, "/var/www/rails/sonnax"
  set :application, "sonnax"
  set :app, "theklaibers.com"
  set :db, "theklaibers.com"  
end

namespace(:deploy) do
  desc 'Move the database.yml file'
  task(:copy_db_config) do
    run("cp #{shared_path}/database.yml #{current_path}/config/database.yml")
  end
  
  desc 'Set the proper permissions for the system folder for uploads'
  task(:fix_paperclip_permissions) do
    run("chmod -R 777 #{current_path}/public/system/")
  end
end


#NOTE: This only needs to be run once, then we will pull down from production on subsequent calls
desc 'Copy local images to shared folder on the server'
task(:copy_shared) do
  run_locally("scp -r /users/nateklaiber/sites/camp_club_girls/public/system/* root@74.50.59.43:#{shared_path}/system/")
end

after 'deploy:symlink', 'deploy:copy_db_config', 'deploy:fix_paperclip_permissions'
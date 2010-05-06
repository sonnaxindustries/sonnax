require 'config/recipes/passenger'
require 'config/recipes/shared_assets'
require 'config/recipes/bundler'
#require 'thinking_sphinx/deploy/capistrano'

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

set :shared_host, 'theklaibers.com'

role :app, 'theklaibers.com'
role :web, 'theklaibers.com'
role :db, 'theklaibers.com', :primary => true

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
  run_locally("scp -r /users/nateklaiber/sites/sonnax/public/system/* root@206.123.113.157:#{shared_path}/system/")
end

after 'deploy:symlink', 'deploy:copy_db_config', 'deploy:fix_paperclip_permissions'
#after "deploy:setup", "thinking_sphinx:shared_sphinx_folder"
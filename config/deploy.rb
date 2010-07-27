require 'config/recipes/passenger'
require 'config/recipes/sonnax'
require 'config/recipes/bundler'
require 'vendor/bundler_gems/gems/thinking-sphinx-1.3.17/lib/thinking_sphinx/deploy/capistrano.rb'

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

set :shared_host, '74.50.61.9'

role :app, '74.50.61.9'
role :web, '74.50.61.9'
role :db, '74.50.61.9', :primary => true

# desc "deploy to the production domain"
# task :production do
#   set :deploy_to, "/var/www/rails/sonnax"
#   set :application, "sonnax"
#   set :app, "theklaibers.com"
#   set :db, "theklaibers.com"  
# end

namespace(:deploy) do
  desc 'Move the database.yml file'
  task(:copy_db_config) do
    run("cp #{shared_path}/database.yml #{current_path}/config/database.yml")
  end
  
  desc 'Set the proper permissions for the system folder for uploads'
  task(:fix_paperclip_permissions) do
    run("chmod -R 777 #{current_path}/public/system/")
  end
  
  desc 'Symlink the static pages directory'
  task(:symlink_pages, :roles => :app) do
    run('ln -s /var/www/rails/sonnax/shared/pages/ /var/www/rails/sonnax/current/app/views/pages/static')
  end
end

#NOTE: This only needs to be run once, then we will pull down from production on subsequent calls
desc 'Copy local images to shared folder on the server'
task(:copy_shared) do
  run_locally("scp -r /users/nateklaiber/sites/sonnax/public/system/* root@206.123.113.157:#{shared_path}/system/")
end

namespace :rake do  
  desc "Run a task on a remote server."  
  # run like: cap staging rake:invoke task=a_certain_task  
  task :invoke do  
    run("cd #{deploy_to}/current; /usr/bin/rake #{ENV['task']} RAILS_ENV=#{rails_env}")  
  end  
end

def rake(*tasks)
  rails_env = fetch(:rails_env, "production")
  rake = fetch(:rake, "rake")
  tasks.each do |t|
    run "if [ -d #{release_path} ]; then cd #{release_path}; else cd #{current_path}; fi; #{rake} RAILS_ENV=#{rails_env} #{t}"
  end
end


after 'deploy:symlink', 'deploy:copy_db_config', 'deploy:fix_paperclip_permissions', 'deploy:symlink_pages'
#after "deploy:setup", "thinking_sphinx:shared_sphinx_folder"
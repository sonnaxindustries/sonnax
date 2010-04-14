#http://gist.github.com/raw/295244/67993455e91ab482db020755181630f0a57070c1/deploy.rb
Capistrano::Configuration.instance.load do
  namespace :bundler do
    task :create_symlink, :roles => :app do
      shared_dir = File.join(shared_path, 'bundle')
      release_dir = File.join(current_release, '.bundle')
      run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
    end
  
    task :bundle_new_release, :roles => :app do
      bundler.create_symlink
      run "cd #{release_path} && bundle install --without test"
    end
  
    task :lock, :roles => :app do
      run "cd #{current_release} && bundle lock;"
    end
  
    task :unlock, :roles => :app do
      run "cd #{current_release} && bundle unlock;"
    end
  end

  # HOOKS
  after "deploy:update_code" do
    bundler.bundle_new_release
  end
end
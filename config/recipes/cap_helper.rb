require 'ostruct'

module SharedAssetManagerBase
  DIRECTORIES = %w( assets avatars pdfs )
  
  def initialize(opts={})
    @options = opts
  end
  
  def shared_host
    @shared_host ||= @options[:shared_host]
  end
  
  def user
    @user ||= @options[:user]
  end
  
  def shared_path
    @shared_path ||= @options[:shared_path]
  end
  
  def local_root_path
    @root_path ||= File.join('public', 'system')
  end
  
  def remote_root_path
    @remote_root_path ||= File.join(shared_path, 'system')
  end
  
  def remote_paths
    @remote_paths ||= DIRECTORIES.map { |directory| [File.join(self.remote_root_path, directory)] }.join(' ')
  end
  
  def local_paths
    @local_paths ||= DIRECTORIES.map { |directory| [File.join(self.local_root_path, directory)] }.join(' ')
  end
  
  def paths
    @paths ||= OpenStruct.new(:remote => remote_paths, :local => local_paths)
  end
  
  def cmd
    raise 'Please provide a command'
  end
  
  def to_s
    "User: %s\nShared Path: %s\nShared Host: %s\nLocal Paths: %s\nRemote Paths: %s\nCommand to Run: %s" % [self.user, self.shared_path, self.shared_host, self.paths.local, self.paths.remote, self.cmd]
  end
end

module SharedAssetManager
  module Destroy
    class Local
      include SharedAssetManagerBase

      def cmd
        @cmd ||= "rm -rf %s" % [self.paths.local]
      end
    end
    
    class Remote
      include SharedAssetManagerBase

      def cmd
        @cmd ||= "rm -rf %s" % [self.paths.remote]
      end
    end
  end
  
  class Pull
    include SharedAssetManagerBase
    
    def cmd
      @cmd ||= "rsync --recursive --times --rsh=ssh --compress --human-readable --progress %s@%s:%s/system/ public/system/" % [self.user, self.shared_host, self.shared_path]
    end
  end
  
  class Push
    include SharedAssetManagerBase
    
    def cmd
      @cmd ||= "scp -r %s %s@%s:%s/system/" % [self.paths.local, self.user, self.shared_host, self.shared_path]
    end
  end
end



module DatabaseManagerBase
  include Capistrano::Configuration::Actions::FileTransfer
  
  def initialize(opts={})
    @options = opts
  end
  
  def current_path
    @current_path ||= @options[:current_path]
  end
  
  def shared_host
    @shared_host ||= @options[:shared_host]
  end
  
  def user
    @user ||= @options[:user]
  end
  
  def shared_path
    @shared_path ||= @options[:shared_path]
  end
  
  def tmp_yml
    File.join(File.dirname(__FILE__)) + '/../../tmp/database.yml'
  end
  
  def remote_yml_path
    "%s/database.yml" % [self.shared_path]
  end
  
  def remote_yml?
    File.exists?(self.remote_yml_path)
  end
  
  def local_yml_path
    File.join(File.dirname(__FILE__)) + '/../database.yml'
  end
  
  def local_yml
    File.join(File.dirname(__FILE__)) + '/../database.yml'
  end
  
  def local_yml?
    File.exists?(self.local_yml_path)
  end
  
  def remote_tmp_yml!
    cmd = "rm %s" % [self.local_yml_path]
    #run_locally(cmd) if self.local_yml?
  end
  
  def remove_sql_dump!
    # if File.exists?(dumped_local_file_path)
    #   run_locally("rm #{dumped_local_file_path}")
    # end
  end
  
  def remote_settings
    @remote_settings ||= OpenStruct.new(YAML::load_file(local_yml)["development"])
  end
  
  def local_settings
    @local_settings ||= OpenStruct.new(YAML::load_file(local_yml)["development"])
  end
  
  def settings
    @settings ||= OpenStruct.new(:local => self.local_settings, :remote => self.remote_settings)
  end
  
  def local_root_path
    @root_path ||= File.join('public', 'system')
  end
  
  def remote_root_path
    @remote_root_path ||= File.join(shared_path, 'system')
  end
  
  def remote_paths
    @remote_paths ||= DIRECTORIES.map { |directory| [File.join(self.remote_root_path, directory)] }.join(' ')
  end
  
  def local_paths
    @local_paths ||= DIRECTORIES.map { |directory| [File.join(self.local_root_path, directory)] }.join(' ')
  end
  
  def cleanup!
    self.remote_tmp_yml!
    self.remove_sql_dump!
  end
  
  def cmd
    raise 'Please provide a command'
  end
  
  def to_s
    "User: %s\nShared Path: %s\nShared Host: %s\nLocal Paths: %s\nRemote Paths: %s\nCommand to Run: %s" % [self.user, self.shared_path, self.shared_host, self.paths.local, self.paths.remote, self.cmd]
  end
end

# get("#{shared_path}/database.yml", "tmp/database.yml")
# 
# remote_settings = YAML::load_file("tmp/database.yml")["production"]
# local_settings = YAML::load_file("config/database.yml")["development"]
# 
# run("mysqldump -u'#{remote_settings["username"]}' -p'#{remote_settings["password"]}' -h'#{remote_settings["host"]}' '#{remote_settings["database"]}' > #{current_path}/tmp/production-#{remote_settings["database"]}-dump.sql")
# 
# run_locally("rsync --times --rsh=ssh --compress --human-readable --progress #{user}@#{shared_host}:#{current_path}/tmp/production-#{remote_settings["database"]}-dump.sql tmp/production-#{remote_settings["database"]}-dump.sql")
# run_locally("mysql -u#{local_settings["username"]} #{"-p#{local_settings["password"]}" if local_settings["password"]} #{local_settings["database"]} < tmp/production-#{remote_settings["database"]}-dump.sql")

# ---- REMOTE DATABASE
#NOTE: We don't have passwords on either DB
# remote_database_yml = "%s/database.yml" % [shared_path]
# puts remote_database_yml
# get(remote_database_yml, "tmp/database.yml")
# 
# local_settings = YAML::load_file('config/database.yml')['development']
# remote_settings = YAML::load_file('tmp/database.yml')['development']
# 
# dumped_file_name = "development-%s-dump.sql" % [local_settings['database']]
# dumped_local_file_path = "tmp/%s" % [dumped_file_name]
# dumped_remote_file_path = "%s/tmp/%s" % [shared_path, dumped_file_name]
# 
# run_local_cmd = "mysqldump -u %s %s > %s && scp -r %s %s@%s:%s/tmp/" % [local_settings['username'], local_settings['database'], dumped_local_file_path, dumped_local_file_path, user, shared_host, shared_path]
# run_remote_cmd = "mysql -u %s %s < %s" % [remote_settings['username'], remote_settings['database'], dumped_remote_file_path]
# 
# puts "Backup up the database locally..."
# run_locally(run_local_cmd)
# 
# puts "Restoring the database on the remote server..."
# run(run_remote_cmd)



module DatabaseManager
  class Pull
    include DatabaseManagerBase
    
    def retrieve_remote_yml
      get(self.remote_yml, self.tmp_yml)
    end
    
    def remote_commands
      @remote_commands ||= OpenStruct.new(:dump => self.cmd_dump_database, :import => self.cmd_import_database, :rsync => self.cmd_rsync, :scp => self.cmd_scp)
    end
    
    def local_commands
      @local_commands ||= OpenStruct.new(:dump => self.cmd_dump_database, :import => self.cmd_import_database, :rsync => self.cmd_rsync, :scp => self.cmd_scp)
    end
    
    def commands
      @commands ||= OpenStruct.new(:local => self.local_commands, :remote => self.remote_commands)
    end
    
    def cmd_scp
      "scp -r"
    end
    
    def cmd_dump_database
      "mysqldump -u %s %s > %s" % [self.settings.local.username, self.settings.local.database, self.settings.remote.database]
    end
    
    def cmd_import_database
      "mysql -u %s %s < tmp/production-%s-dump.sql" % [self.settings.local.username, self.settings.local.database, self.settings.remote.database]
    end
    
    def cmd_rsync
      "rsync --times --rsh=ssh --compress --human-readable --progress %s@%s:%s/tmp/production-%s-dump.sql tmp/production-%s-dump.sql" % [self.user, self.shared_host, self.current_path, self.settings.remote.database, self.settings.remote.database]
    end
  end
  
  class Push
    include DatabaseManagerBase
    
    def remote_commands
      @remote_commands ||= OpenStruct.new(:dump => self.cmd_dump_database, :import => self.cmd_import_database, :rsync => self.cmd_rsync, :scp => self.cmd_scp)
    end
    
    def local_commands
      @local_commands ||= OpenStruct.new(:dump => self.cmd_dump_database, :import => self.cmd_import_database, :rsync => self.cmd_rsync, :scp => self.cmd_scp)
    end
    
    def commands
      @commands ||= OpenStruct.new(:local => self.local_commands, :remote => self.remote_commands)
    end
    
    def cmd_scp
      "scp -r"
    end
    
    def cmd_dump_database
      "mysqldump -u %s %s > %s" % [self.settings.local.username, self.settings.local.database, self.settings.remote.database]
    end
    
    def cmd_import_database
      "mysql -u %s %s < tmp/production-%s-dump.sql" % [self.settings.local.username, self.settings.local.database, self.settings.remote.database]
    end
    
    def cmd_rsync
      "rsync --times --rsh=ssh --compress --human-readable --progress %s@%s:%s/tmp/production-%s-dump.sql tmp/production-%s-dump.sql" % [self.user, self.shared_host, self.current_path, self.settings.remote.database, self.settings.remote.database]
    end
  end
end
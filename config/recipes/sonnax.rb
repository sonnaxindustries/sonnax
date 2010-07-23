Capistrano::Configuration.instance.load do
  namespace(:sonnax) do
    namespace(:assets) do
      desc "Push the assets to the remote server"
      task(:push) do
        puts "Pushing the local assets to the remote server.."
      end
      
      desc 'Destroy the shared Paperclip assets'
      task(:destroy) do
        directories = %w( assets avatars pdfs )
        path = File.join(shared_path, 'system')
        
        directories.each do |directory|
          rm_cmd = "rm -rf %s" % [File.join(path, directory)]
          puts "Removing %s..." % [rm_cmd]
          run(rm_cmd)
        end
      end
    end
  end
end
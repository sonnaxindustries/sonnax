require 'paperclip'

Paperclip.interpolates(:resource_name) do |attachment, style|
  attachment.instance.channel.resource_name
end

if RAILS_ENV == "development" 
  Paperclip.options[:command_path] = '/opt/local/bin/' 
else 
  Paperclip.options[:command_path] = '/usr/local/bin' 
end

Paperclip.options[:log_command] = true
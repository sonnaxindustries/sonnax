require 'paperclip'

Paperclip.interpolates(:resource_name) do |attachment, style|
  attachment.instance.channel.resource_name
end

if Rails.env.development?
  #Paperclip.options.merge!(:command_path => '/opt/local/bin')
  Paperclip.options.merge!(:command_path => '/usr/local/bin')
else 
  Paperclip.options.merge!(:command_path => '/usr/local/bin')
end

Paperclip.options.merge!(:log_command => true)

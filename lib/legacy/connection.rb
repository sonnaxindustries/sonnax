class Legacy::Connection < ActiveRecord::Base
  self.abstract_class = true
  establish_connection(YAML.load(File.open(File.join(Rails.root, 'config', 'database.yml'), 'r'))['legacy'])
end
class Converters::PartAttributeType < PartAttributeType
  class << self
    def run!
      ActiveRecord::Base.connection.execute('TRUNCATE part_attribute_types')
      Legacy::Part.product_attribute_keys.each do |r|
        params = {
          :name => r.name,
          :key_name => r.key_name
        }
        
        self.create!(params)
      end
    end
  end
end
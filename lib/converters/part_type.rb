class Converters::PartType < PartType
  class << self
    def run!
      ActiveRecord::Base.connection.execute('TRUNCATE part_types')
      Legacy::Part.part_type_keys.each do |r|
        params = {
          :name => r,
        }
        
        self.create!(params)
      end
    end
  end
end
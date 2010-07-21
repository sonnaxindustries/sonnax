class Converters::PartAssetType < PartAssetType
  class << self
    def run!
      ActiveRecord::Base.connection.execute('TRUNCATE part_asset_types')
      Legacy::Part.part_asset_keys.each do |r|
        params = {
          :name => r.name,
          :key_name => r.key_name
        }
        
        self.create!(params)
      end
    end
  end
end
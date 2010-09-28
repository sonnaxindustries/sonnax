class Converters::PartAsset < PartAsset
  class << self
    def truncate!
      ActiveRecord::Base.connection.execute('TRUNCATE part_assets')
    end
  end
end
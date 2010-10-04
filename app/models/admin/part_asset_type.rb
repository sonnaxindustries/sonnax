class Admin::PartAssetType < PartAssetType
  has_many :part_assets, :class_name => 'Admin::PartAsset'
  has_many :parts, :through => :part_assets
  
  validates_uniqueness_of :name
  
  class << self
    def options
      self.all.map { |p| [p.name, p.id] }
    end
  end
end
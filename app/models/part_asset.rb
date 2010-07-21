class PartAsset < ActiveRecord::Base
  belongs_to :part
  belongs_to :part_asset_type
  belongs_to :asset
  
  validates_uniqueness_of :part_id, :scope => [:part_asset_type_id, :asset_id]
  
  def validate
    self.errors.add(:part, 'Please provide a Part ID') unless self.part_id?
    self.errors.add(:part_asset, 'Please provide a Part Asset Type') unless self.part_asset_type_id?
    self.errors.add(:asset, 'Please provide an Asset') unless self.asset_id?
  end
end

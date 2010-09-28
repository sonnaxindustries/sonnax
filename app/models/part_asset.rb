class PartAsset < ActiveRecord::Base
  belongs_to :part
  belongs_to :part_asset_type
  belongs_to :asset
  belongs_to :photo, :class_name => 'PartPhoto', :foreign_key => 'asset_id'
  
  validates_uniqueness_of :part_id, :scope => [:part_asset_type_id, :asset_id]
  
  named_scope :photos, :conditions => { :part_asset_type_id => PartAssetType.photo }
  named_scope :resources, :conditions => ["part_asset_type_id NOT IN (?)", PartAssetType.photo]
  
  def photo?
    !self.photo.blank?
  end
  
  def validate
    self.errors.add(:part, 'Please provide a Part ID') unless self.part_id?
    self.errors.add(:part_asset, 'Please provide a Part Asset Type') unless self.part_asset_type_id?
    self.errors.add(:asset, 'Please provide an Asset') unless self.asset_id?
  end
end

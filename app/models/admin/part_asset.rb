class Admin::PartAsset < PartAsset
  attr_accessor :asset_src

  belongs_to :part, :class_name => 'Admin::Part'
  belongs_to :part_asset_type, :class_name => 'Admin::PartAssetType'
  belongs_to :asset, :class_name => 'Admin::Asset'
  
  accepts_nested_attributes_for :asset
  
  validates_uniqueness_of :part_id, :scope => [:part_asset_type_id, :asset_id]
  
  def validate
    self.errors.add(:part, 'Please provide a Part ID') unless self.part_id?
    self.errors.add(:part_asset, 'Please provide a Part Asset Type') unless self.part_asset_type_id?
    self.errors.add(:asset, 'Please provide an Asset') unless self.asset_id?
  end
  
  def asset?
    !self.asset.blank?
  end

  def asset_src=(val)
    filename = val['asset']
    if self.new_record?
      asset_obj = Admin::Asset.create(:asset => filename)
      self.asset = asset_obj
    else
      self.asset.update_attributes(:asset => filename)
    end
  end

end

class Admin::Asset < Asset
  has_attached_file :asset
  
  has_many :part_assets, :class_name => 'Admin::PartAssets'
  has_many :parts, :through => :part_assets
  
  def parts?
    self.parts.any?
  end
end
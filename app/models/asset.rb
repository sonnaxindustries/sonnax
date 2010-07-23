class Asset < ActiveRecord::Base
  has_attached_file :asset
  
  has_many :part_assets
  has_many :parts, :through => :part_assets
  
  def parts?
    self.parts.any?
  end
end

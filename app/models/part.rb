class Part < ActiveRecord::Base
  belongs_to :part_type
  belongs_to :product_line
  
  has_many :part_attributes, :dependent => :destroy
  
  has_many :part_assets, :dependent => :destroy
  has_many :assets, :through => :part_assets
  
  has_many :part_photos, :dependent => :destroy
  has_many :photos, :through => :part_photos, :source => :asset
  
  named_scope :recent, :conditions => ["parts.created_at >= ?", 1.month.ago]
  named_scope :featured, :conditions => ["parts.is_featured = ?", true]
  
  def validate
    self.errors.add(:product_line, 'Please provide a product line ID') unless self.product_line_id?
  end
  
  def before_save
    self.part_type_id = PartType.default.id unless self.part_type_id?
  end
  
  def primary_photo
    self.part_assets.photos.first
  end
  
  def primary_photo?
    !self.primary_photo.blank?
  end
end

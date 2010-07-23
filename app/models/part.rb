class Part < ActiveRecord::Base
  belongs_to :part_type
  belongs_to :product_line
  
  has_many :part_attributes, :dependent => :destroy
  
  has_many :part_assets, :dependent => :destroy
  has_many :assets, :through => :part_assets
  
  has_many :part_photos, :dependent => :destroy
  has_many :photos, :through => :part_photos, :source => :asset
  
  define_index do
    indexes :part_number, :sortable => true
    indexes :oem_part_number, :sortable => true
    indexes :description
    indexes :item
    indexes :notes    
    
    has created_at, updated_at, part_type_id, product_line_id
  end
  
  #NOTE: For some reason, when running the indexer, it fails for the 1.month.ago. This has to be commented out in order to index parts
  named_scope :recent, :conditions => ["parts.created_at >= ?", 1.month.ago]
  named_scope :featured, :conditions => ["parts.is_featured = ?", true]
  named_scope :random_featured, :conditions => ["parts.is_featured = ?", true], :limit => 1, :order => 'RAND()'
  
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

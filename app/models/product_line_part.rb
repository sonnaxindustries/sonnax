class ProductLinePart < ActiveRecord::Base
  belongs_to :part
  belongs_to :product_line
  
  validates_uniqueness_of :part_id, :scope => [:product_line_id]
  
  named_scope :featured_for_product_line, lambda { |product_line| { :conditions => ["product_line_id = ? AND is_featured = ?", product_line, true] }}
  named_scope :featured, :conditions => ["product_line_parts.is_featured = ?", true]
  
  def validate
    self.errors.add(:product_line, 'Please provide a Product Line ID') unless self.product_line_id?
    self.errors.add(:part, 'Please provide a Part ID') unless self.part_id?
  end
  
  def previous_featured
    if self.new_record?
      self.class.find(:first, :conditions => ["product_line_id = ? AND is_featured = ?", self.product_line_id, true])
    else
      self.class.find(:first, :conditions => ["product_line_id = ? AND is_featured = ? AND id <> ?", self.product_line_id, true, self.id])
    end
  end
  
  def previous_featured?
    !self.previous_featured.blank?
  end
  
  def remove_old_featured!
    self.previous_featured.update_attributes(:is_featured => false) if self.previous_featured?
  end
  
  def mark_as_featured!
    self.remove_old_featured!
    self.is_featured = true
    self.save(false)
  end
  
  def featured?
    self.is_featured
  end
end

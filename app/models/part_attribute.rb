class PartAttribute < ActiveRecord::Base
  belongs_to :part
  belongs_to :part_attribute_type
  
  validates_uniqueness_of :part_id, :scope => [:part_attribute_type_id]
  
  def validate
    self.errors.add(:part, 'Please provide a Part ID') unless self.part_id?
    self.errors.add(:part_attribute_type, 'Please provide a Part Attribute ID') unless self.part_attribute_type_id?
    self.errors.add(:attr_value, 'Please provide a value for the attribute') unless self.attr_value?
  end
end

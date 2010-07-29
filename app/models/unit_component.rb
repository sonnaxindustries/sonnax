class UnitComponent < ActiveRecord::Base
  belongs_to :unit
  belongs_to :part
  
  def validate
    self.errors.add(:unit_id, 'Please provide a Unit') unless self.unit_id?
    self.errors.add(:part_id, 'Please provide a Part') unless self.part_id?
  end
end

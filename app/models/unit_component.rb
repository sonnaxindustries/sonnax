class UnitComponent < ActiveRecord::Base
  class MissingUnitIds < StandardError; end
  belongs_to :unit
  belongs_to :part
  
  define_index do
    indexes code_on_reference_figure, :sortable => true
    indexes part.part_number, :as => :part_number, :sortable => true
    indexes unit.name, :as => :unit_name
    indexes unit.product_line_id, :as => :product_line_id, :sortable => true
    
    where "parts.part_number <> ''"
    group_by 'unit_components.code_on_reference_figure'
    
    has code_on_reference_figure
    has part_id, unit_id, created_at, updated_at
  end
  
  class << self
    def make_for_part(part)
      results = self.all(:select => 'unit_components.unit_id', 
                         :conditions => ["unit_components.part_id = ?", part])
      unit_ids = results.map(&:unit_id)
      raise MissingUnitIds.new('No unit ids associated') if unit_ids.compact.blank?
      UnitsMake.make_for_unit_ids(unit_ids)
    end
  end
  
  def validate
    self.errors.add(:unit_id, 'Please provide a Unit') unless self.unit_id?
    self.errors.add(:part_id, 'Please provide a Part') unless self.part_id?
  end
end

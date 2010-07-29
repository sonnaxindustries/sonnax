class Legacy::UnitComponent < Legacy::Connection
  set_table_name 'unit_components'
  
  belongs_to :unit, :class_name => 'Legacy::Unit', :foreign_key => 'unit_id'
  belongs_to :part, :class_name => 'Legacy::Part', :foreign_key => 'assembly_or_part_id'
  
  named_scope :list, :conditions => ["unit_components.component_type = ?", '0']
  
  def valid_unit?
    !self.unit.blank? && self.unit._model_record?
  end
  
  def valid_part?
    !self.part.blank? && self.part._model_record?
  end
  
  def create?
    self.valid_unit? && self.valid_part?
  end
end
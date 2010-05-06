class Legacy::UnitMake < Legacy::Connection
  set_table_name 'unit_makes'
  
  belongs_to :unit, :class_name => 'Legacy::Unit', :foreign_key => 'unit_id'
  belongs_to :make, :class_name => 'Legacy::Make', :foreign_key => 'make_id'
  
  def create_record?
    self.unit? && self.make? && self.unit._model_record? && self.make._model_record?
  end
  
  def make?
    !self.make.blank?
  end
  
  def unit?
    !self.unit.blank?
  end
  
  def _model_record
    UnitsMake.find_by_unit_id_and_make_id(self.unit.id, self.make.id)
  end
  
  def _model_record?
    !self._model_record.blank?
  end
end
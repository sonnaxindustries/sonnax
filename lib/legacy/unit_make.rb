class Legacy::UnitMake < Legacy::Connection
  set_table_name 'unit_makes'
  
  belongs_to :unit, :class_name => 'Legacy::Unit', :foreign_key => 'unit_id'
  belongs_to :make, :class_name => 'Legacy::Make', :foreign_key => 'make_id'
  
  def _model_record
    UnitsMake.find_by_unit_id_and_make_id(self.unit.id, self.make.id)
  end
  
  def _model_record?
    !self._model_record.blank?
  end
end
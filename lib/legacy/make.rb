class Legacy::Make < Legacy::Connection
  set_table_name 'makes'
  
  has_many :unit_makes, :class_name => 'Legacy::UnitMake'
  has_many :units, :through => :unit_makes
  
  def _model_record
    ::Make.find_by_name(self.make)
  end
  
  def _model_record?
    !self._model_record.blank?
  end
end
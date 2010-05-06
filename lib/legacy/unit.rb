class Legacy::Unit < Legacy::Connection
  set_table_name 'units'
  
  has_many :unit_makes, :class_name => 'Legacy::UnitMake'
  has_many :makes, :through => :unit_makes
  
  belongs_to :product_line, :class_name => 'Legacy::ProductLine', :foreign_key => 'product_line'
  belongs_to :ref_figure, :class_name => 'Legacy::RefFigure', :foreign_key => 'ref_figure_id'
  
  def product_line?
    !self.product_line.blank?
  end
  
  def ref_figure?
    !self.ref_figure.blank?
  end
  
  def _model_record
    ::Unit.find_by_name(self.name)
  end
  
  def _model_record?
    !self._model_record.blank?
  end
end
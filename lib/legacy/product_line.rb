class Legacy::ProductLine < Legacy::Connection
  set_table_name 'product_lines'
  has_many :order_parts, :class_name => 'Legacy::OrderPart', :foreign_key => 'product_line'
  has_many :parts, :class_name => 'Legacy::Part', :foreign_key => 'product_line'
  
  has_many :featured, :class_name => 'Legacy::PartsFeatured'
  has_many :units, :class_name => 'Legacy::Unit', :foreign_key => 'product_line'
  
  def _model_record
    ::ProductLine.find_by_name(self.name)
  end
  
  def _model_record?
    !self._model_record.blank?
  end
end
class Legacy::RefFigure < Legacy::Connection
  set_table_name 'ref_figures'
  
  has_many :units, :class_name => 'Legacy::Unit', :foreign_key => 'ref_figure_id'
  
  def _model_record
    ReferenceFigure.find_by_name(self.name)
  end
  
  def _model_record?
    !self._model_record.blank?
  end
  
  def avatar_filename
    @avatar_filename ||= if self.exploded_view_file?
      File.join(Rails.root, 'public', 'file_conversions', 'exploded-views', self.exploded_view_file) 
    else
      ''
    end
  end
  
  def avatar_file?
    File.exists?(self.avatar_filename)
  end
  
  def avatar_file
    @avatar_file ||= File.new(self.avatar_filename)
  end
  
  def text_file_filename
    @text_file_filename ||= if self.text_file?
      File.join(Rails.root, 'public', 'file_conversions', 'exploded-views', self.text_file) 
    else
      ''
    end
  end
  
  def text_file_file?
    File.exists?(self.text_file_filename)
  end
  
  def text_file_file
    @text_file_file ||= File.new(self.text_file_filename)
  end
end
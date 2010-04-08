class Legacy::RefFigure < Legacy::Connection
  set_table_name 'ref_figures'
  
  has_many :units, :class_name => 'Legacy::Unit', :foreign_key => 'ref_figure_id'
end
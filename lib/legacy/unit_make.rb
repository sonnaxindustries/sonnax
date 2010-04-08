class Legacy::UnitMake < Legacy::Connection
  set_table_name 'unit_makes'
  
  belongs_to :unit, :class_name => 'Legacy::Unit', :foreign_key => 'unit_id'
  belongs_to :make, :class_name => 'Legacy::Make', :foreign_key => 'make_id'
end
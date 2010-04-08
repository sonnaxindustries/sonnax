class Legacy::UnitComponent < Legacy::Connection
  set_table_name 'unit_components'
  
  belongs_to :unit, :class_name => 'Legacy::Unit', :foreign_key => 'unit_id'
end
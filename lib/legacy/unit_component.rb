class Legacy::UnitComponent < Legacy::Connection
  set_table_name 'unit_components'
  
  belongs_to :unit, :class_name => 'Legacy::Unit', :foreign_key => 'unit_id'
  belongs_to :part, :class_name => 'Legacy::Part', :foreign_key => 'assembly_or_part_id'
end
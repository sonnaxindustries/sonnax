class Legacy::SpeedOrderTemp < Legacy::Connection
  set_table_name 'speed_order_temp'
  
  belongs_to :part, :class_name => 'Legacy::Part', :foreign_key => 'part_number', :primary_key => 'part_number'
end
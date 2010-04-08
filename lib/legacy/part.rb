class Legacy::Part < Legacy::Connection
  set_table_name 'parts'
  belongs_to :product_line, :class_name => 'Legacy::ProductLine', :foreign_key => 'product_line'
  
  has_one :featured, :class_name => 'Legacy::PartsFeatured'
  has_many :speed_orders, :class_name => 'Legacy::SpeedOrderTemp', :foreign_key => 'part_number', :primary_key => 'part_number'
end
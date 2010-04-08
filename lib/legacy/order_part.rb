class Legacy::OrderPart < Legacy::Connection
  set_table_name 'order_parts'
  
  belongs_to :order, :class_name => 'Legacy::Order'
  belongs_to :part, :class_name => 'Legacy::Part'
  belongs_to :product_line, :class_name => 'Legacy::ProductLine', :foreign_key => 'product_line'
end
class Legacy::PartsFeatured < Legacy::Connection
  set_table_name 'parts_featured'
  
  belongs_to :product_line, :class_name => 'Legacy::ProductLine', :foreign_key => 'product_line_id'
  belongs_to :part, :class_name => 'Legacy::Part'
end
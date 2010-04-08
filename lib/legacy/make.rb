class Legacy::Make < Legacy::Connection
  set_table_name 'makes'
  
  has_many :unit_makes, :class_name => 'Legacy::UnitMake'
  has_many :units, :through => :unit_makes
end
class Legacy::PublicationCategory < Legacy::Connection
  set_table_name 'publication_categories'
  
  has_many :publication_subcategories, :class_name => 'Legacy::PublicationSubcategory', :foreign_key => 'publication_category'
end
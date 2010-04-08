class Legacy::PublicationSubcategory < Legacy::Connection
  set_table_name 'publication_subcategories'
  
  belongs_to :publication_category, :class_name => 'Legacy::PublicationCategory', :foreign_key => 'publication_category'
  
  has_many :subcategory_titles, :class_name => 'Legacy::PublicationSubcategoryTitle', :foreign_key => 'subcategory_id'
end
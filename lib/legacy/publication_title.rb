class Legacy::PublicationTitle < Legacy::Connection
  set_table_name 'publication_titles'
  
  has_many :subcategory_titles, :class_name => 'Legacy::PublicationSubcategoryTitle', :foreign_key => 'title_id'
end
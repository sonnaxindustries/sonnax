class Legacy::PublicationSubcategoryTitle < Legacy::Connection
  set_table_name 'publication_subcategory_titles'
  
  belongs_to :subcategory, :class_name => 'Legacy::PublicationSubcategory', :foreign_key => 'subcategory_id'
  belongs_to :title, :class_name => 'Legacy::PublicationTitle', :foreign_key => 'title_id'
end
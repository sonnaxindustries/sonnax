class Legacy::PublicationSubcategory < Legacy::Connection
  set_table_name 'publication_subcategories'
  
  belongs_to :publication_category, :class_name => 'Legacy::PublicationCategory', :foreign_key => 'publication_category'
  
  has_many :subcategory_titles, :class_name => 'Legacy::PublicationSubcategoryTitle', :foreign_key => 'subcategory_id'
  has_many :titles, :through => :subcategory_titles
  
  def titles?
    self.titles.any?
  end
  
  def col_title
    # Map based on ID of the category
  end
  
  def col_author
  end
  
  def col_date
  end
  
  def col_volume
  end
end
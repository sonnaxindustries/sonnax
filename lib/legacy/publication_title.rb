class Legacy::PublicationTitle < Legacy::Connection
  set_table_name 'publication_titles'
  
  has_many :subcategory_titles, :class_name => 'Legacy::PublicationSubcategoryTitle', :foreign_key => 'title_id'
  
  def pdf_filename
    @pdf_filename ||= if self.pdf?
      File.join(Rails.root, 'public', 'file_conversions', 'tech-articles', self.pdf) 
    else
      ''
    end
  end
  
  def pdf_file?
    File.exists?(self.pdf_filename)
  end
  
  def pdf_file
    @pdf_file ||= File.new(self.pdf_filename)
  end
end
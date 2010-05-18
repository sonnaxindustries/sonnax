class Import::Excel::Publication
  
  class Type
    def initialize(attrs={})
      @attributes = attrs
    end
    
    def title
      @title ||= @attributes[:title]
    end
  end
  
  class Author
    def initialize(attrs={})
      @attributes = attrs
    end
    
    def name
      @name ||= @attributes[:name]
    end
  end
  
  class Subject
    def initialize(attrs={})
      @attributes = attrs
    end
    
    def title
      @title ||= @attributes[:title]
    end
  end
  
  class Category
    def initialize(attrs={})
      @attributes = attrs
      self.parse_title!
    end
    
    def title_name
      @title_name ||= @attributes[:title_name]
    end
    
    def title
      @parsed_title.last
    end
    
    def sort_order
      @parsed_title.first.gsub('.', '')
    end
    
    def parse_title!
      @parsed_title = self.title_name.split(' ', 2)
    end
  end
    
  class Row
    def initialize(attrs={})
      @attributes = attrs
    end
    
    def title
      @title ||= @attributes[:title]
    end
    
    def publication_category
      @publication_category ||= @attributes[:publication_category]
    end
    
    def category
      Category.find_by_name(self.publication_category)
    end
    
    def publication_type
      @publication_type ||= @attributes[:publication_type]
    end
    
    def type
      PublicationType.find_by_name(self.publication_type)
    end
    
    def publication_subject
      @publication_subject ||= @attributes[:publication_subject]
    end
    
    def subject
      PublicationSubject.find_by_name(self.publication_subject)
    end
    
    def date
      return nil if @attributes[:date].blank?
      @date ||= Date.parse(@attributes[:date])
    end
    
    def author_name
      @author_name ||= @attributes[:author_name]
    end
    
    def author
      PublicationAuthor.find_by_full_name(self.author_name)
    end
    
    def pdf_filename
      @pdf_filename ||= @attributes[:pdf_filename]
    end
    
    def pdf_filename?
      !self.pdf_filename.blank?
    end
    
    def pdf
      File.new(File.join(Rails.root, 'public', 'file_conversions', 'tech-articles', self.pdf_filename))
    end
    
    def pdf?
      !self.pdf.blank?
    end
    
    def product_line_id
      @product_line_id ||= @attributes[:product_line_id]
    end
    
    def product_line
      Legacy::ProductLine.find(self.product_line_id)
    end
    
    def make_name
      @make_name ||= @attributes[:make_name]
    end
    
    def make
      Legacy::Make.find_by_make(self.make_name)
    end
    
    def unit_name
      @unit_name ||= @attributes[:unit_name]
    end
    
    def unit
      Legacy::Unit.find_by_name(self.unit_name)
    end
    
    def keywords
      @keywords ||= @attributes[:keywords]
    end
  end
  
  def initialize
    @file_name = File.join(Rails.root, 'lib', 'import', 'excel', 'docs', 'publication_data.xls')
    self.setup_sheet!
  end
  
  def setup_sheet!
    self.workbook.default_sheet = self.publications_worksheet
  end
  
  def import!
    self.records.each do |publication|
    end
  end
  
  def workbook
    @workbook ||= Excel.new(@file_name)
  end
  
  def start_column
    2
  end
  
  def start_row
    3
  end
  
  def publications_worksheet
    @publications_worksheet ||= self.workbook.sheets[2]
  end
  
  def publication_categories
    @publication_categories ||= self.records.map(&:publication_category).uniq.compact
  end
  
  def categories
    self.publication_categories.inject([]) { |arr,val| arr << Category.new(:title_name => val); arr }
  end
  
  def publication_types
    @publication_types ||= self.records.map(&:publication_type).uniq.compact
  end
  
  def types
    self.publication_types.inject([]) { |arr,val| arr << Type.new(:title => val); arr }
  end
  
  def publication_subjects
    @publication_subjects ||= self.records.map(&:publication_subject).uniq.compact
  end
  
  def subjects
    self.publication_subjects.inject([]) { |arr,val| arr << Subject.new(:title => val); arr }
  end
  
  def publication_authors
    @publication_authors ||= self.records.map(&:author_name).uniq.compact
  end
  
  def authors
    self.publication_authors.inject([]) { |arr,val| arr << Author.new(:name => val); arr }
  end
  
  def records
    self.parse_records!
    @record_objects
  end
  
  def parse_records!
    @record_objects = []
    (self.start_row..self.workbook.last_row).each_with_index do |index,row|
      @record_objects << Row.new(
                               :title_id              => self.workbook.cell(index, 2),
                               :publication_category  => self.workbook.cell(index, 3),
                               :publication_type      => self.workbook.cell(index, 4),
                               :title                 => self.workbook.cell(index, 5),
                               :publication_subject   => self.workbook.cell(index, 6),
                               :date                  => self.workbook.cell(index, 7),
                               :author_name           => self.workbook.cell(index, 8),
                               :pdf_filename          => self.workbook.cell(index, 9),
                               :product_line_id       => self.workbook.cell(index, 10),
                               :make_name             => self.workbook.cell(index, 11),
                               :unit_name             => self.workbook.cell(index, 12),
                               :keywords => OpenStruct.new(:rebuilding  => self.workbook.cell(index, 13),
                                                           :diagnosis   => self.workbook.cell(index, 14),
                                                           :complaint   => self.workbook.cell(index, 15),
                                                           :correction  => self.workbook.cell(index, 16)
                              )
                )
      @record_objects
    end
  end
end



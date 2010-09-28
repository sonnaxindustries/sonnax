class Import::Excel::Publication

  class << self
    def keyword_types_hash
      {
        :rebuilding     => 'General Rebuilding Tip',
        :diagnosis      => 'Diagnosis',
        :complaint      => 'Complaint',
        :correction     => 'Correction'
      }
    end
    
    def import_all!(options={})
      #self.import!(:drop_tables => true, :file_name => 'publication_data_TC_091610.xls')
      self.import!(:drop_tables => true, :file_name => 'publication_data_transmission_091610.xls')
    end

    def import!(options={})
      drop_tables = options.delete(:drop_tables)
      file_name   = options.delete(:file_name)
      
      should_drop_tables = if drop_tables then true else false end
      
      if should_drop_tables
        tables = %w( publication_categories_titles publication_titles_units_makes publication_titles_authors publication_titles_product_lines publication_titles_subjects publication_titles_types publication_titles_keywords publication_keyword_types publication_keywords publication_categories publication_authors publication_titles publication_types publication_subjects )
      
        puts 'Dropping the old tables of information....'
        tables.each do |tbl|
          stmt = "TRUNCATE %s" % [tbl]
          ActiveRecord::Base.connection.execute(stmt)
        end
      end

      klass = self.new(file_name)
      puts 'Importing authors...'
      klass.import_authors!

      puts 'Importing categories...'
      klass.import_categories!

      puts 'Importing subjects...'
      klass.import_subjects!

      puts 'Importing types....'
      klass.import_types!

      puts 'Importing titles...'
      klass.import_titles!

      puts 'Importing associated data...'
      klass.import_associated_data!
    end
  end

  class Type
    def initialize(attrs={})
      @attributes = attrs
    end

    def title
      @title ||= @attributes[:title]
    end

    def to_params
      {
        :title => self.title
      }
    end
  end

  class Author
    def initialize(attrs={})
      @attributes = attrs
    end

    def name
      @name ||= @attributes[:name]
    end

    def name?
      !self.name.blank?
    end

    def first_name
      self.name.split(' ', 2).first if self.name?
    end

    def last_name
      self.name.split(' ', 2).last if self.name?
    end

    def to_params
      {
        :first_name => self.first_name,
        :last_name => self.last_name,
        :full_name => self.name
      }
    end
  end

  class Subject
    def initialize(attrs={})
      @attributes = attrs
    end

    def title
      @title ||= @attributes[:title]
    end

    def to_params
      {
        :title => self.title
      }
    end
  end

  class Category
    def initialize(attrs={})
      @attributes = attrs
      self.parse_title!
    end

    class << self
      def find_by_name(name)
        record = Import::Excel::Publication.new.categories.select { |cat| cat.title == name }
        return record.first unless record.blank?
      end

      def find_by_title_name(name)
        record = Import::Excel::Publication.new.categories.select { |cat| cat.title_name == name }
        return record.first unless record.blank?
      end
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

    def to_params
      {
        :name => self.title,
        :sort_order => self.sort_order
      }
    end
  end

  class Row
    def initialize(attrs={})
      @attributes = attrs
    end

    def <=>(other)
      self.id <=> other.id
    end

    def id
      @id ||= @attributes[:title_id].to_i
    end

    def title
      @title ||= @attributes[:title]
    end

    def publication_category
      @publication_category ||= @attributes[:publication_category]
    end

    def publication_category_object
      Import::Excel::Publication::Category.find_by_title_name(self.publication_category)
    end

    def category
      PublicationCategory.find_by_name(self.publication_category_object.title)
    end

    def publication_type
      @publication_type ||= @attributes[:publication_type]
    end

    def type
      PublicationType.find_by_title(self.publication_type)
    end
    
    def type?
      !self.type.blank?
    end

    def publication_subject
      @publication_subject ||= @attributes[:publication_subject]
    end

    def subject
      PublicationSubject.find_by_title(self.publication_subject)
    end

    def subject?
      !self.subject.blank?
    end

    def date
      return nil if @attributes[:date].blank?
      @date ||= @attributes[:date]
    end

    def author_name
      @author_name ||= @attributes[:author_name]
    end

    def author
      PublicationAuthor.find_by_full_name(self.author_name)
    end

    def author?
      !self.author.blank?
    end

    def pdf_filename
      @pdf_filename ||= @attributes[:pdf_filename]
    end

    def pdf_filename?
      !self.pdf_filename.blank?
    end

    def pdf_file_exists?
      File.exists?(File.join(Rails.root, 'public', 'file_conversions', 'tech-articles', self.pdf_filename)) if self.pdf_filename?
    end

    def pdf
      File.new(File.join(Rails.root, 'public', 'file_conversions', 'tech-articles', self.pdf_filename)) if self.pdf_file_exists?
    end

    def pdf?
      !self.pdf.blank?
    end

    def product_line_id
      @product_line_id ||= @attributes[:product_line_id]
    end

    def legacy_product_line
      Legacy::ProductLine.find(self.product_line_id)
    end

    def product_line
      ProductLine.find_by_name(self.legacy_product_line.name)
    end

    def make_name
      @make_name ||= @attributes[:make_name]
    end

    def legacy_make
      Legacy::Make.find_by_make(self.make_name)
    end

    def legacy_make?
      !self.legacy_make.blank?
    end

    def make
      Make.find_by_name(self.legacy_make.make) if self.legacy_make?
    end

    def make?
      !self.make.blank?
    end

    def unit_name
      @unit_name ||= @attributes[:unit_name]
    end

    def legacy_unit
      Legacy::Unit.find_by_name(self.unit_name)
    end

    def legacy_unit?
      !self.legacy_unit.blank?
    end

    def unit
      Unit.find_by_name(self.legacy_unit.name) if self.legacy_unit?
    end

    def unit?
      !self.unit.blank?
    end

    def unit_and_make?
      self.unit? && self.make?
    end

    def unit_make
      UnitsMake.find_by_make_id_and_unit_id(self.make.id, self.unit.id) if self.unit_and_make?
    end

    def unit_make?
      !self.unit_make.blank?
    end

    def keywords
      @keywords ||= @attributes[:keywords]
    end

    def all_keywords
      Import::Excel::Publication.keyword_types_hash.keys.inject([]) do |arr,kt|
        keyword_type = PublicationKeywordType.find_by_title(Import::Excel::Publication.keyword_types_hash[kt])
        arr << PublicationKeyword.find_by_publication_keyword_type_id_and_title(keyword_type.id, self.keywords.send(kt)) if !self.keywords.send(kt).nil? && keyword_type
        arr
      end
    end

    def all_keywords?
      self.all_keywords.any?
    end

    def to_params
      {
        :title => self.title,
        :pdf => self.pdf,
        :published_at => self.date
      }
    end
  end

  def initialize(filename = nil)
    file_to_import = filename || 'publication_data_transmission_091610.xls'
    @file_name = File.join(Rails.root, 'lib', 'import', 'excel', 'docs', file_to_import)
    self.setup_sheet!
  end

  def setup_sheet!
    #self.workbook.default_sheet = self.publications_worksheet
  end

  def import!
    self.records.each do |publication|
    end
  end

  def workbook
    @workbook ||= ::Excel.new(@file_name)
  end

  def start_column
    2
  end

  def start_row
    3
  end

  def import_associated_data!
    self.records.each do |record|
      record_object = PublicationTitle.find_by_title(record.title)
      puts "Attaching publication (%s) to category..." % [record_object.title]
      record_object.categories << record.category unless record_object.categories.include?(record.category)

      puts "Attaching publication (%s) to subject..." % [record_object.title]
      record_object.subjects << record.subject if record.subject? && !record_object.subjects.include?(record.subject)

      puts "Attaching publication (%s) to type..." % [record_object.title]
      record_object.types << record.type if record.type? && !record_object.types.include?(record.type)

      puts "Attaching publication (%s) to product line..." % [record_object.title]
      record_object.product_lines << record.product_line unless record_object.product_lines.include?(record.product_line)

      puts "Attaching publication (%s) to author..." % [record_object.title]
      record_object.authors << record.author if record.author? && !record_object.authors.include?(record.author)

      puts "Attaching publication (%s) to units..." % [record_object.title]
      record_object.units << record.unit if record.unit? && !record_object.units.include?(record.unit)

      puts "Attaching publication (%s) to makes..." % [record_object.title]
      record_object.makes << record.make if record.make? && !record_object.makes.include?(record.make)

      puts "Attaching publication (%s) to unit_makes..." % [record_object.title]
      record_object.units_makes << record.unit_make if record.unit_make? && !record_object.units_makes.include?(record.unit_make)
    end
  end

  def import_titles!
    self.unique_records.map { |publication| PublicationTitle.create(publication.to_params) }
  end

  def import_categories!
    self.categories.map { |category| PublicationCategory.create(category.to_params) }
  end

  def import_subjects!
    self.subjects.map { |subject| PublicationSubject.create(subject.to_params) }
  end

  def import_types!
    self.types.map { |type| PublicationType.create(type.to_params) }
  end

  def import_keyword_types!
    self.keyword_types_hash.values.map { |keyword_type| PublicationKeywordType.create(:title => keyword_type) }
  end

  def import_by_keyword_type!(keyword_type)
    pub_type = PublicationKeywordType.find_by_title(self.keyword_types_hash[keyword_type])
    self.publication_keywords.send(keyword_type).map { |keyword| PublicationKeyword.create(:publication_keyword_type_id => pub_type.id, :title => keyword) }
  end

  def import_rebuilding_keywords!
    self.import_by_keyword_type!(:rebuilding)
  end

  def import_diagnosis_keywords!
    self.import_by_keyword_type!(:diagnosis)
  end

  def import_complaint_keywords!
    self.import_by_keyword_type!(:complaint)
  end

  def import_correction_keywords!
    self.import_by_keyword_type!(:correction)
  end

  def import_keywords!
    self.keyword_types_hash.keys.map { |kt| self.send("import_#{kt.to_s}_keywords!") }
  end

  def keyword_types_hash
    {
      :rebuilding     => 'General Rebuilding Tip',
      :diagnosis      => 'Diagnosis',
      :complaint      => 'Complaint',
      :correction     => 'Correction'
    }
  end

  def keyword_types
    @keyword_types ||= OpenStruct.new(self.keyword_types_hash)
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

  def authors?
    self.authors.any?
  end

  def rebuilding_keywords
    self.records.map(&:keywords).map(&:rebuilding).uniq.compact
  end

  def diagnosis_keywords
    self.records.map(&:keywords).map(&:diagnosis).uniq.compact
  end

  def complaint_keywords
    self.records.map(&:keywords).map(&:complaint).uniq.compact
  end

  def correction_keywords
    self.records.map(&:keywords).map(&:correction).uniq.compact
  end

  def publication_keywords
    @publication_keywords ||= OpenStruct.new(:rebuilding    => self.rebuilding_keywords,
                                             :diagnosis     => self.diagnosis_keywords,
                                             :complaint     => self.complaint_keywords,
                                             :correction    => self.correction_keywords)
  end

  def import_authors!
    self.authors.map { |author| PublicationAuthor.create(author.to_params) }
  end

  def records
    self.parse_records!
    @record_objects
  end

  def unique_records
    @unique_records ||= self.records.inject([]) { |arr,val| arr << val unless arr.map(&:id).include?(val.id); arr }
  end

  def parse_records!
    @record_objects = []
    (self.start_row..self.workbook.last_row).each_with_index do |index,row|
      @record_objects << Row.new(
                               :title_id              => self.workbook.cell(index, 1),
                               :publication_category  => self.workbook.cell(index, 2),
                               :publication_type      => self.workbook.cell(index, 3),
                               :title                 => self.workbook.cell(index, 4),
                               :publication_subject   => self.workbook.cell(index, 11),
                               :date                  => self.workbook.cell(index, 5),
                               :author_name           => self.workbook.cell(index, 6),
                               :pdf_filename          => self.workbook.cell(index, 7),
                               :product_line_id       => self.workbook.cell(index, 8),
                               :make_name             => self.workbook.cell(index, 9),
                               :unit_name             => self.workbook.cell(index, 10)
                )
      @record_objects
    end
  end
end



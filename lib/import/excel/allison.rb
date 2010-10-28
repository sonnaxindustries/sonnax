# Add a unit component
# Make is a constant of Make.find_by_name('Allison') == Allison
# Product Line is a constant of ProductLine.find(4) == Allison
class Import::Excel::Allison
  
  class << self
    def import!
      klass = self.new
      
      puts 'Attaching Allison parts to unit makes...'
      klass.import_unit_makes!
      
      puts "Attaching Allison parts to unit components..."
      klass.import_unit_components!
    end
  end
  
  class Row
    def initialize(attrs={})
      @attributes = attrs
    end
    
    def make
      Make.find(20)
    end
    
    def product_line_name
      @product_line_name ||= @attributes[:product_line_name]
    end
    
    def product_line
      ProductLine.find_by_name(self.product_line_name)
    end
    
    def unit_name
      @unit_name ||= @attributes[:unit_name]
    end
    
    def unit
      Unit.find_by_name(self.unit_name)
    end
    
    def part_number
      @part_number ||= @attributes[:part_number]
    end
    
    def part
      Part.find_by_part_number_and_product_line_id(self.part_number, 4)
    end
    
    def units_make?
      UnitsMake.exists?(:unit_id => self.unit.id, :make_id => self.make.id)
    end
    
    def unit_component?
      UnitComponent.exists?(:unit_id => self.unit.id, :part_id => self.part.id)
    end
  end
  
  attr_accessor :file_name, :document_name

  def initialize(filename = nil)
    @document_name = filename || 'allison.xls'
    @file_name = File.join(Rails.root, 'lib', 'import', 'excel', 'docs', @document_name)
  end

  def workbook
    @workbook ||= ::Excel.new(@file_name)
  end

  def start_column
    2
  end

  def start_row
    2
  end

  def publications_worksheet
    @publications_worksheet ||= self.workbook.sheets[2]
  end
  
  def import_unit_makes!
    self.records.each do |record|
      UnitsMake.create!(:unit => record.unit, :make => record.make) unless record.units_make?
    end
  end
  
  def import_unit_components!
    self.records.each do |record|
      UnitComponent.create!(:unit => record.unit, :part => record.part) unless record.unit_component?
    end
  end

  def records
    self.parse_records!
    @record_objects
  end

  def unique_records
    @unique_records ||= self.records.inject([]) { |arr,val| arr << val unless arr.map(&:part_number).include?(val.part_number); arr }
  end
  
  def import_units!
    missing_units = self.records.select { |u| u.unit.blank? }
    missing_units.map { |unit| Unit.create(:product_line_id => unit.product_line.id, :name => unit.unit_name) }
  end
  
  def patch_records!
    self.records.each do |record|
      
    end
  end

  def parse_records!
    @record_objects = []
    (self.start_row..self.workbook.last_row).each_with_index do |index,row|
      @record_objects << Row.new(
                               :product_line_name   => self.workbook.cell(index, 1),
                               :part_number         => self.workbook.cell(index, 2),
                               :unit_name           => self.workbook.cell(index, 6)
                )
      @record_objects
    end
  end
end



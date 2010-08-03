class Legacy::Part < Legacy::Connection
  set_table_name 'parts'
  belongs_to :product_line, :class_name => 'Legacy::ProductLine', :foreign_key => 'product_line'
  
  has_many :unit_components, :class_name => 'Legacy::UnitComponent', :foreign_key => 'assembly_or_part_id', :conditions => ['unit_components.component_type = ?', 0]
  
  has_one :featured, :class_name => 'Legacy::PartsFeatured'
  has_many :speed_orders, :class_name => 'Legacy::SpeedOrderTemp', :foreign_key => 'part_number', :primary_key => 'part_number'
  
  named_scope :part_types, :select => 'DISTINCT(parts.part_type)', :conditions => ["parts.part_type IS NOT NULL and parts.part_type != ''"]
  named_scope :parts_with_numbers, :conditions => ["(parts.part_number IS NOT NULL AND parts.part_number != '')"]
  named_scope :parts_with_product_lines, :conditions => ["(parts.product_line NOT IN (8,9,10,11))"]
  named_scope :by_product_line, lambda { |product_line| { :conditions => ["parts.product_line = ?", product_line] }}
  named_scope :limited, lambda { |limit| { :limit => limit }}
  
  PART_ATTRIBUTE_KEYS = [:thick, :pitch, :no_of_teeth, :inner_diameter, :chamfer, :steel_driveshaft_tube_od, :outer_diameter, :tube_diameter, :torque_fuse_options]
  PART_ASSET_KEYS = [:photo, :announcement, :instructions, :tech, :vbfix]
  
  class << self
    def list
      #self.parts_with_numbers.parts_with_product_lines#.limited(20)
      self.all
    end
    
    def product_attribute_keys
      PART_ATTRIBUTE_KEYS.inject([]) { |ar,val| ar << OpenStruct.new(:name => val.to_s.humanize, :key_name => val.to_s) }
    end
    
    def part_asset_keys
      PART_ASSET_KEYS.inject([]) { |ar,val| ar << OpenStruct.new(:name => val.to_s.humanize, :key_name => val.to_s) }
    end
    
    def part_photos
      photos = []
      self.list.each do |part|
        if part.photo?
          photos << OpenStruct.new(:filename => part.photo_filename)
        end
      end
      photos
    end
    
    def part_type_keys
      records = if self.part_types.any?
        self.part_types.map(&:part_type).unshift('Uncategorized')
      else
        ['Uncategorized']
      end
    end
  end
  
  def _model_record
    ::Part.find(:first, :conditions => ["parts.product_line_id = ? AND parts.part_number = ? AND item = ? AND notes = ?", self.product_line_id, self.part_number, self.item, self.notes])
  end
  
  def _model_record?
    !self._model_record.blank?
  end
  
  def product_line_id
    self.product_line._model_record.id
  end
  
  def part_type_object
    @part_type_object ||= PartType.find_by_name(self.part_type)
  end
  
  def featured?
    !self.featured.blank?
  end
  
  def name
    self.part_number
  end
  
  def part_attributes
    self.class::PART_ATTRIBUTE_KEYS.inject([]) do |ar,val| 
      part_attribute_type = PartAttributeType.find_by_key_name(val.to_s)
      part_attribute_value = self.send(val)
      ar << OpenStruct.new(:part_attribute_type => part_attribute_type, :attr_value => part_attribute_value)
      ar
    end
  end
  
  # PHOTO
  def photo_filename
    @photo_filename ||= if self.photo?
      File.join(Rails.root, 'public', 'file_conversions', 'part-images', self.photo) 
    else
      ''
    end
  end
  
  def photo_file?
    File.exists?(self.photo_filename)
  end
  
  def photo_file
    @photo_file ||= File.new(self.photo_filename) if self.photo_file?
  end
  
  # ANNOUNCEMENTS
  def announcement_filename
    @announcement_filename ||= if self.announcement?
      File.join(Rails.root, 'public', 'file_conversions', 'announcements', self.announcement) 
    else
      ''
    end
  end
  
  def announcement_file?
    File.exists?(self.announcement_filename)
  end
  
  def announcement_file
    @announcement_file ||= File.open(self.announcement_filename) if self.announcement_file?
  end
  
  # INSTRUCTIONS
  def instructions_filename
    @instructions_filename ||= if self.instructions?
      File.join(Rails.root, 'public', 'file_conversions', 'instructions', self.instructions) 
    else
      ''
    end
  end
  
  def instructions_file?
    File.exists?(self.instructions_filename)
  end
  
  def instructions_file
    @instructions_file ||= File.open(self.instructions_filename) if self.instructions_file?
  end
  
  # TECH
  def tech_filename
    @tech_filename ||= if self.tech?
      File.join(Rails.root, 'public', 'file_conversions', 'tech', self.tech) 
    else
      ''
    end
  end
  
  def tech_file?
    File.exists?(self.tech_filename)
  end
  
  def tech_file
    @tech_file ||= File.open(self.tech_filename) if self.tech_file?
  end
  
  # VBFIX
  def vbfix_filename
    @vbfix_filename ||= if self.vbfix?
      File.join(Rails.root, 'public', 'file_conversions', 'tech-articles', self.vbfix) 
    else
      ''
    end
  end
  
  def vbfix_file?
    File.exists?(self.vbfix_filename)
  end
  
  def vbfix_file
    @vbfix_file ||= File.open(self.vbfix_filename) if self.vbfix_file?
  end
end
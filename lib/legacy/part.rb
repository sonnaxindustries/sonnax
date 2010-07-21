class Legacy::Part < Legacy::Connection
  set_table_name 'parts'
  belongs_to :product_line, :class_name => 'Legacy::ProductLine', :foreign_key => 'product_line'
  
  has_one :featured, :class_name => 'Legacy::PartsFeatured'
  has_many :speed_orders, :class_name => 'Legacy::SpeedOrderTemp', :foreign_key => 'part_number', :primary_key => 'part_number'
  
  named_scope :part_types, :select => 'DISTINCT(parts.part_type)', :conditions => ["parts.part_type IS NOT NULL and parts.part_type != ''"]
  
  PART_ATTRIBUTE_KEYS = [:thick, :pitch, :no_of_teeth, :inner_diameter, :chamfer, :steel_driveshaft_tube_od, :outer_diameter, :tube_diameter, :torque_fuse_options]
  
  class << self
    def product_attribute_keys
      PART_ATTRIBUTE_KEYS.inject([]) { |ar,val| ar << OpenStruct.new(:name => val.to_s.humanize, :key_name => val.to_s) }
    end
    
    def part_type_keys
      records = if self.part_types.any?
        self.part_types.map(&:part_type).unshift('Uncategorized')
      else
        ['Uncategorized']
      end
    end
  end
  
  def part_attributes
    self.class::PART_ATTRIBUTE_KEYS.inject([]) do |ar,val| 
      part_attribute = PartAttributeType.find_by_key_name(val.to_s)
      part_attribute_value = self.send(val)
      ar << OpenStruct.new(:part_attribute => part_attribute, :attr_value => part_attribute_value)
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
    @photo_file ||= File.new(self.photo_filename)
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
    @announcement_file ||= File.new(self.announcement_filename)
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
    @instructions_file ||= File.new(self.instructions_filename)
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
    @tech_file ||= File.new(self.tech_filename)
  end
  
  # VBFIX
  def tech_filename
    @tech_filename ||= if self.tech?
      File.join(Rails.root, 'public', 'file_conversions', 'instructions', self.tech) 
    else
      ''
    end
  end
  
  def tech_file?
    File.exists?(self.tech_filename)
  end
  
  def tech_file
    @tech_file ||= File.new(self.tech_filename)
  end
end
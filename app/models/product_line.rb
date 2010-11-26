class ProductLine < ActiveRecord::Base
  has_many :units, :dependent => :nullify
  has_many :parts, :dependent => :nullify
  
  has_many :publication_product_lines, :class_name => 'PublicationTitlesProductLine', :dependent => :destroy
  has_many :publications, :through => :publication_product_lines
  
  named_scope :sorted, :order => 'sort_order DESC'
  named_scope :active, :conditions => { :is_active => true }
  
  define_index do
    indexes :name, :sortable => true
    
    where 'is_active = 1'
    
    has created_at, updated_at
  end
  
  class << self
    def speed_order_options
      self.find(:all, 
                :conditions => ["url_friendly IN (?)", %w( allison transmission high-performance-transmission torque-converter )],
                :order => 'name ASC').map { |r| [r.unescaped_name, r.id] }
    end
    
    def all_with_parts
      self.find(:all, 
                :conditions => ["url_friendly IN (?)", %w( allison transmission torque-converter driveline high-performance-transmission ring-gears )],
                :order => 'name ASC')
    end
    
    def all_with_new_parts
      self.find(:all, 
                :conditions => ["url_friendly IN (?)", %w( allison transmission high-performance-transmission torque-converter )],
                :order => 'name ASC')
    end
    
    def transmission
      self.find_by_type!('ProductLines::Transmission')
    end
    
    def high_performance_transmission
      self.find_by_type!('ProductLines::HighPerformanceTransmission')
    end
    
    def torque_converter
      self.find_by_type!('ProductLines::Converter')
    end
    
    def ring_gears
      self.find_by_type!('ProductLines::RingGear')
    end
    
    def driveline
      self.find_by_type!('ProductLines::Driveline')
    end
    
    def power_train_savers
      self.find_by_type!('ProductLines::PowerTrainSaver')
    end
    
    def allison
      self.find_by_type!('ProductLines::Allison')
    end
    
    def detail!(id)
      self.find_by_url_friendly!(id, :conditions => { :is_active => true })
    end
    
    def list
      self.active.sorted
    end
  end
  
  def unescaped_name
    CGI.unescapeHTML(self.escape_ampersand)
  end

  def escape_ampersand
    self.name.gsub(/\&reg;/, " (R)")
  end
  
  def associated_units(attrs={})
    attrs.merge!(:product_line => self)
    Part.find_units_by_filter(attrs)
  end
  
  def unit_options(attrs={})
    self.associated_units(attrs).map { |unit| [unit.name, unit.id] }
  end
  
  def associated_makes(attrs={})
    attrs.merge!(:product_line => self)
    Part.find_makes_by_filter(attrs)
  end
  
  def make_options(attrs={})
    self.associated_makes(attrs).map { |make| [make.name, make.id] }
  end
  
  def underscored_name
    self.url_friendly.underscore
  end
  
  def featured_parts
    self.parts.random_featured
  end
  
  def units?
    self.units.any?
  end
  
  # NOTE: This was used for the initial import, and can be removed post launch
  def type_name
    name_to_cast = case self.name
    when 'High Performance Transmission'
      'High Performance Transmission'
    when 'Torque Converter &amp; HP Converter'
      'Converter'
    when 'Transmission'
      'Transmission'
    when 'Ring Gears'
      'Ring Gear'
    when 'Allison&reg;'
      'Allison'
    when 'Power Train Savers&reg;'
      'Power Train Saver'
    when 'High Performance Torque Converter'
      'High Performance Converter'
    when 'Driveline'
      'Driveline'
    else
      self.name
    end
    
    type_name = name_to_cast.extend(Helper::String).to_type_name
  end
  
  def generate_type!
    "ProductLines::%s" % [self.type_name]
  end
  
  def generate_url_friendly!
    formatted_friendly = self.name.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s-%s" % [formatted_friendly, n.to_s]))
    return "%s-%s" % [formatted_friendly, n.to_s]
  end
  
  def before_create
    self.type = self.generate_type!
    self.url_friendly = self.generate_url_friendly!
  end
end

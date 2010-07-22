class ProductLine < ActiveRecord::Base
  has_many :units, :dependent => :nullify
  
  has_many :publication_product_lines, :class_name => 'PublicationTitlesProductLine', :dependent => :destroy
  has_many :publications, :through => :publication_product_lines
  
  has_many :product_line_parts, :dependent => :destroy, :include => [:part]
  has_many :parts, :through => :product_line_parts
  
  named_scope :sorted, :order => 'sort_order DESC'
  named_scope :active, :conditions => { :is_active => true }
  
  define_index do
    indexes :name, :sortable => true
    
    where 'is_active = 1'
    
    has created_at, updated_at
  end
  
  class << self
    def transmission
      self.find_by_url_friendly!('transmission')
    end
    
    def high_performance_transmission
      self.find_by_url_friendly!('high-performance-transmission')
    end
    
    def torque_converter
      self.find_by_url_friendly!('torque-converter')
    end
    
    def ring_gears
      self.find_by_url_friendly!('ring-gears')
    end
    
    def driveline
      self.find_by_url_friendly!('driveline')
    end
    
    def power_train_savers
      self.find_by_url_friendly!('power-train-savers')
    end
    
    def allison
      self.find_by_url_friendly!('allison')
    end
    
    def detail!(id)
      self.find_by_url_friendly!(id, :conditions => { :is_active => true })
    end
    
    def list
      self.active.sorted
    end
  end
  
  def underscored_name
    self.url_friendly.underscore
  end
  
  def featured_parts
    self.product_line_parts.featured
  end
  
  def units?
    self.units.any?
  end
  
  def generate_url_friendly!
    formatted_friendly = self.name.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s-%s" % [formatted_friendly, n.to_s]))
    return "%s-%s" % [formatted_friendly, n.to_s]
  end
  
  def before_create
    self.url_friendly = self.generate_url_friendly!
  end
end

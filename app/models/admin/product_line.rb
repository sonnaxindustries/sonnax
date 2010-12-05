class Admin::ProductLine < ProductLine
  has_many :units, :class_name => 'Admin::Unit'
  named_scope :list, :order => 'sort_order ASC, name ASC'
  
  def self.inheritance_column
      '_not_valid' #NOTE: This gets set here to avoid trying to use the STI class of Admin::ProductLine
    end
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
    
    def base_class
      ProductLine
    end
    
    def options
      self.all.map { |p| [p.name, p.id] }
    end
  end

  def associated_units(attrs={})
    attrs.merge!(:product_line => self)
    Admin::Unit.options_for(attrs)
  end
  
  def unit_options(attrs={})
    self.associated_units(attrs).map { |unit| [unit.name, unit.id] }
  end

  def published_status
    if self.is_active? then 'Active' else 'Inactive' end
  end
  
  def to_param
    self.id.to_s
  end
end

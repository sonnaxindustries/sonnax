class ProductLine::Transmission::FormPresenter
  include ActionController::UrlWriter
  
  def initialize(attrs={})
    @attributes = attrs
  end
  
  def url
    filter_product_line_parts_path(self.product_line.url_friendly)
  end
  
  def q
    #
  end
  
  def product_line
    @product_line ||= @attributes[:product_line]
  end
  
  def units
    @units ||= @attributes[:units]
  end
  
  def unit_options
    if self.make?
      self.product_line.unit_options(:make => self.make).unshift(['-- Select Unit --', ''])
    else
      self.units.map { |unit| [unit.name, unit.id] }
    end
  end
  
  def makes
    @makes ||= @attributes[:makes]
  end
  
  def make_options
    self.makes.map { |make| [make.name, make.id] }
  end
  
  def unit
    @unit ||= @attributes[:unit]
  end
  
  def unit?
    !self.unit.blank?
  end
  
  def unit_id
    if self.unit? then self.unit.id else nil end
  end
  
  def make
    @make ||= @attributes[:make]
  end
  
  def make?
    !self.make.blank?
  end
  
  def make_id
    if self.make? then self.make.id else nil end
  end
end
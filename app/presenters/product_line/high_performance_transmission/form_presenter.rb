class ProductLine::HighPerformanceTransmission::FormPresenter
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
    self.units.map { |unit| [unit.name, unit.id] }
  end
  
  def makes
    @makes ||= @attributes[:makes]
  end
  
  def make_options
    self.makes.map { |make| [make.name, make.id] }
  end
  
  def unit
    #
  end
  
  def make
    #
  end
end
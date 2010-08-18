require 'ostruct'
class ProductLine::HighPerformanceTransmission::CollectionPresenter
  include ActionController::UrlWriter
  
  def initialize(attrs={})
    @attributes = attrs
  end
  
  def product_line_parts
    @product_line_parts ||= @attributes[:parts]
  end
  
  def product_line
    @product_line ||= @attributes[:product_line]
  end
  
  def make
    @make ||= @attributes[:make]
  end
  
  def unit
    @unit ||= @attributes[:unit]
  end
  
  def parts_count
  end
end
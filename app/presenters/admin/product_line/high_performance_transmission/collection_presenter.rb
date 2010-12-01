require 'ostruct'
class Admin::ProductLine::HighPerformanceTransmission::CollectionPresenter
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

  def make?
    !self.make.blank?
  end
  
  def unit
    @unit ||= @attributes[:unit]
  end

  def unit?
    !self.unit.blank?
  end
  
  def parts_count
  end

  def redirect_url
    if self.make? && !self.unit?
      filter_admin_product_line_parts_path(self.product_line.id, :"filter[make]" => self.make.id)
    elsif self.make? && self.unit?
      filter_admin_product_line_parts_path(self.product_line.id, :"filter[make]" => self.make.id, :"filter[unit]" => self.unit.id)
    end
  end
end

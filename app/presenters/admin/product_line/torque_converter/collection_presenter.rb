require 'ostruct'
class Admin::ProductLine::TorqueConverter::CollectionPresenter
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
  
  def reference_number
  end
  
  def parts_count
  end
  
  def sorted_and_grouped_parts
    self.product_line_parts.group_by(&:code_on_reference_figure).sort_by { |r| r[0].to_i }
  end
  
  def multiple_parts?
  end

  def labels_by_make
    # This will be used to list out the labels, each by make, then by associated units
    
  end
  
  def parts_by_reference_number
    self.sorted_and_grouped_parts.map do |part| 
      parts = part[1]
      parts_count = parts.size
      has_multiple_parts = (parts_count > 1)
      reference_number = parts.first.code_on_reference_figure
      
      OpenStruct.new(:reference_number => reference_number,
                     :parts => parts,
                     :parts_count => parts_count,
                     :multiple_parts? => has_multiple_parts)
    end
  end

  def redirect_url
    if self.make? && !self.unit?
      filter_admin_product_line_parts_path(self.product_line.id, :"filter[make]" => self.make.id)
    elsif self.make? && self.unit?
      filter_admin_product_line_parts_path(self.product_line.id, :"filter[make]" => self.make.id, :"filter[unit]" => self.unit.id)
    end
  end
end

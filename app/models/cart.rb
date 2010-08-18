class Cart
  attr_reader :parts
  
  def initialize
    @parts = []
  end
  
  class << self
    def from_parts_hash(parts_hash)
      kart = self.new
      parts_hash.each do |part|
        if !part[1].blank?
          part = Part.find(part[0])
          if part
            kart.add_part(part)
          end
        end
      end
    end
  end
  
  def add_multiple_speed_order_parts(parts_hash)
    product_line_id = parts_hash['product_line_id'].to_i
    part_orders = parts_hash['parts'].values.flatten
    
    part_orders.each do |part|
      quantity = part['quantity'].to_i
      part_number = part['part_number']

      if quantity > 0
        part_record = Part.find_by_part_number_and_product_line_id(part_number, product_line_id)
        
        if part_record
          self.add_part(part_record, quantity)
        end
      end
    end
  end
  
  def add_multiple_parts(parts_hash)
    part_orders = parts_hash['parts'].values.flatten
    
    part_orders.each do |part|
      quantity = part['quantity'].to_i
      part_number = part['part_number']

      if quantity > 0
        part_record = Part.find_by_part_number(part_number)
        if part_record
          self.add_part(part_record, quantity)
        end
      end
    end
  end
  
  def remove_part(part)
    @parts.delete_if { |item| item.part == part }
  end
  
  def add_part(part, quantity = 1)
    current_part = @parts.find { |item| item.part == part }
    if current_part
      current_part.increment_quantity!(quantity.to_i)
    else
      @parts << CartItem.new(part, quantity.to_i)
    end
  end
  
  def parts?
    @parts.any?
  end
end
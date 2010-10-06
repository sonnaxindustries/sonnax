#TODO: Refactor
class Cart
  class Error
    attr_accessor :part_number, :message
    
    def initialize(part_number, message)  
      @part_number = part_number
      @message = message
    end
  end
  attr_reader :parts, :errors
  
  def initialize
    @parts = []
    @errors = []
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
  
  def update_parts!(parts_hash)
    part_orders = parts_hash.first.values

    part_orders.each do |part|
      quantity = part['quantity'].to_i
      
      cart_item = @parts.select { |item| item.part_number == part['part_number'] }.first
      if cart_item
        cart_item.update_quantity!(quantity)
        
        @parts.delete_if { |item| item.quantity == 0 }
      end
    end
  end
  
  def valid?
    !self.errors?
  end
  
  def errors?
    self.errors.size > 0
  end

  def add_multiple_speed_order_parts(parts_hash)
    @errors = []
    product_line_id = parts_hash['product_line_id'].to_i   
    product_line = ProductLine.find(product_line_id) 
    part_orders = parts_hash['parts'].values.flatten
    
    part_orders.each do |part|

      quantity = part['quantity'].to_i
      part_number = part['part_number']

      if quantity > 0
        
        part_record = Part.find_by_part_number_and_product_line_id(part_number, product_line_id)
        
        if part_record
          self.add_part(part_record, quantity)
        else
          error_message = "Part %s could not be found in %s" % [part_number, product_line.name]
          self.errors << Cart::Error.new(part_number, error_message)
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
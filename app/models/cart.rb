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
  
  def add_from_speed_order(parts_hash)
    parts_hash.each do |row|
      attrs = row[1]
      if !attrs['quantity'].blank?
        part = Part.find_by_part_number(attrs['part_number'])
        if part
          self.add_part(part, attrs['quantity'])
        end
      end
    end
  end
  
  def add_multiple_parts(parts_hash)
    parts_hash.each do |part|
      if !part[1].blank?
        part_record = Part.find(part[0])
        if part_record
          self.add_part(part_record, part[1].to_i)
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
      current_part.increment_quantity!
    else
      @parts << CartItem.new(part, quantity.to_i)
    end
  end
  
  def parts?
    @parts.any?
  end
end
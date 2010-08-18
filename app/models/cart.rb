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
  
  def add_multiple_parts(parts_hash)
    parts_hash.each do |part|
      if !part[1].blank?
        part = Part.find(part[0])
        if part
          self.add_part(part)
        end
      end
    end
  end
  
  def remove_part(part)
    @parts.delete_if { |item| item.part == part }
  end
  
  def add_part(part)
    current_part = @parts.find { |item| item.part == part }
    if current_part
      current_part.increment_quantity!
    else
      @parts << CartItem.new(part)
    end
  end
  
  def parts?
    @parts.any?
  end
end
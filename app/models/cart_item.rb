class CartItem
  attr_reader :part, :quantity
  
  def initialize(part, quantity = 1)
    @part = part
    @quantity = quantity.to_i
  end
  
  def increment_quantity!
    @quantity += 1
  end
  
  def name
    @part.name
  end
  
  def part_id
    @part.id
  end
  
  def item
    @part.item
  end
  
  def description
    @part.description
  end
end
class CartItem
  attr_reader :part, :quantity, :extra_quantity
  
  def initialize(part, quantity = 1)
    @part = part
    @quantity = quantity
  end
  
  def increment_quantity!(by = 1)
    @quantity += by
  end
  
  def update_quantity!(amt)
    @quantity = amt
  end
  
  def part_number
    @part.part_number
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
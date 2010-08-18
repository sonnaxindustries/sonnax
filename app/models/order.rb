class Order < ActiveRecord::Base
  attr_accessor :part_groups_to_save
  has_many :line_items
  has_many :parts, :through => :line_items
  
  SHIPPING_METHODS = { :ups_ground  => 'UPS Ground', 
                       :ups_3_day   => 'UPS 3rd Day Select',
                       :ups_2day    => 'UPS 2nd Day',
                       :ups_next    => 'UPS Next Day'
                      }
  class << self
    def shipping_method_options
      self::SHIPPING_METHODS.map { |f| [f[1], f[0]] }.reverse
    end
  end
  
  def line_items?
    self.line_items.any?
  end
  
  def parts?
    self.parts.any?
  end
  
  def formatted_shipping_method
    method = if self.shipping_method? then self.shipping_method.to_sym else :ups_ground end
    SHIPPING_METHODS[method]
  end
  
  def add_line_items
   @part_groups_to_save.each do |cart_item|
      part = Part.find(cart_item['part_id'])
      quantity = cart_item['quantity'].to_i

      if part
        if self.line_items.exists?(:part_id => part.id)
          line_item = self.line_items.find_by_part_id(part.id)
          
          if quantity == 0
            line_item.destroy
          else
            line_item.update_attributes(:quantity => quantity)
          end
          
        else
          
          if quantity > 0
            self.line_items.create(:part_id => part.id, :quantity => quantity)
          end
        end
      end
    end
  end
  
  def part_groups=(arr)
    @part_groups_to_save = arr.first.values   
  end
  
  def part_groups
    [self.line_items.inject({}) { |hsh,li| hsh[li.part.id.to_s] = { 'quantity' => li.quantity.to_s, 'part_number' => li.part.part_number }; hsh }]
  end
  
  def validate
    self.errors.add(:name, 'Please provide your name') unless self.name?
    self.errors.add(:company, 'Please provide your company') unless self.company?
    self.errors.add(:postal_code, 'Please provide your zip code') unless self.postal_code?
    self.errors.add(:email, 'Please provide your email address') unless self.email?
  end
  
  def after_save
    self.add_line_items
  end
end

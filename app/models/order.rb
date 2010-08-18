class Order < ActiveRecord::Base
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
  
  def validate
    self.errors.add(:name, 'Please provide your name') unless self.name?
    self.errors.add(:company, 'Please provide your company') unless self.company?
    self.errors.add(:postal_code, 'Please provide your zip code') unless self.postal_code?
    self.errors.add(:email, 'Please provide your email address') unless self.email?
  end
  
end

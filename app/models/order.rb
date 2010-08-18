class Order < ActiveRecord::Base
  SHIPPING_METHODS = { :ups_ground  => 'UPS Ground', 
                       :ups_3_day   => 'UPS 3rd Day Select',
                       :ups_2day    => 'UPS 2nd Day',
                       :ups_next    => 'UPS Next Day'
                      }
  def validate
    self.errors.add(:name, 'Please provide your name') unless self.name?
    self.errors.add(:company, 'Please provide your company') unless self.company?
    self.errors.add(:postal_code, 'Please provide your zip code') unless self.postal_code?
    self.errors.add(:email, 'Please provide your email address') unless self.email?
  end
end

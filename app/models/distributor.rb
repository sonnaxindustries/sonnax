class Distributor < ActiveRecord::Base
  
  def to_param
    self.url_friendly
  end
end
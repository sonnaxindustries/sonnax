class Make < ActiveRecord::Base
  has_many :units_makes, :dependent => :destroy
  has_many :units, :through => :units_makes
  
  named_scope :list, :order => 'id ASC'
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
  end
  
  def units?
    self.units.any?
  end
  
  def to_param
    self.url_friendly
  end
end

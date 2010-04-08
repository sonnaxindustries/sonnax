class Legacy::Distributor < Legacy::Connection
  set_table_name 'ts_distributors'
  
  named_scope :for_us, :conditions => ["country IN (?)", ['USA']]
  
  class << self
    def with_multiple_locations
      self.all.select(&:multiple_locations?)
    end
    
    def state_list
      self.all.map(&:state).uniq.select { |r| !r.blank? }
    end
    
    def city_list
      self.all.map(&:city).uniq.select { |r| !r.blank? }
    end
  end
  
  def formatted_name
    self.name.gsub('*', '')
  end
  
  def multiple_locations?
    self.name.include?('*')
  end
end
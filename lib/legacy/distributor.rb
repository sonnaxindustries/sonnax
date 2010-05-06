class Legacy::Distributor < Legacy::Connection
  attr_accessor :formatted_email, :formatted_url
  
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
  
  def determine_email_and_url!
    if self.url.include?('@')
      self.formatted_email = self.url
    else
      self.formatted_url = self.formatted_website_url
    end
  end
  
  def url_protocol?
    (self.url =~ /^https?:\/\//) == 0
  end
  
  def url_with_protocol
    "http://%s" % [self.url]
  end
  
  def formatted_website_url
    return nil unless self.url?
    if self.url_protocol? then self.url else self.url_with_protocol end
  end
  
  def formatted_name
    self.name.gsub('*', '')
  end
  
  def multiple_locations?
    self.name.include?('*')
  end
end
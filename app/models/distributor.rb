class Distributor < ActiveRecord::Base
  named_scope :list
  named_scope :by_state, lambda { |name| { :conditions => ["state = ?", name] }}
  named_scope :by_country, lambda { |name| { :conditions => ["country = ?", name] }}
  named_scope :by_city, lambda { |name| { :conditions => ["city = ?", name] }}
  
  define_index do
    indexes :name, :sortable => true
    indexes country, :sortable => true
    indexes state, :sortable => true
    indexes city, :sortable => true
    indexes website_url
    
    has created_at, updated_at
  end
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
  end
  
  def to_param
    self.url_friendly
  end
  
  def website_url_protocol?
    (self.website_url =~ /^https?:\/\//) == 0
  end
  
  def website_url_with_protocol
    "http://%s" % [self.website_url]
  end
  
  def formatted_website_url
    if self.website_url_protocol? then self.website_url else self.website_url_with_protocol end
  end
  
  def generate_url_friendly!
    formatted_friendly = self.name.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s-%s" % [formatted_friendly, n.to_s]))
    return "%s-%s" % [formatted_friendly, n.to_s]
  end
  
  def before_save
    self.url_friendly = self.generate_url_friendly!
  end
end
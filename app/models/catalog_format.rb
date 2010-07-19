class CatalogFormat < ActiveRecord::Base
  def validate
    self.errors.add(:title, 'Please provide a title') unless self.title?
  end
  
  def generate_url_friendly!
    formatted_friendly = self.title.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s-%s" % [formatted_friendly, n.to_s]))
    return "%s-%s" % [formatted_friendly, n.to_s]
  end
  
  def before_create
    self.url_friendly = self.generate_url_friendly!
  end
end

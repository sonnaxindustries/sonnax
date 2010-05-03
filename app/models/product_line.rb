class ProductLine < ActiveRecord::Base
  
  def generate_url_friendly!
    formatted_friendly = self.name.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    new_friendly = "%s-%s" % [formatted_friendly, n.to_s]
    n += 1 while self.class.exists?(:url_friendly => new_friendly)
    return "%s-%s" % [formatted_friendly, n.to_s]
  end
  
  def before_save
    self.url_friendly = self.generate_url_friendly!
  end
end

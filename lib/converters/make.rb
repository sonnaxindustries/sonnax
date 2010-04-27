class Converters::Make < Make
  class << self
    def run!
      Legacy::Make.all.each do |m|
        params = {
          :name => m.make
        }
        self.create!(params)
      end
    end
  end
  
  def generate_url_friendly!
    formatted_friendly = self.name.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    new_friendly = "%s-%s" % [formatted_friendly, n.to_s]
    n += 1 while self.class.exists?(:url_friendly => new_friendly)
    return "%s-%s" % [formatted_friendly, n.to_s]
  end
  
  def generate_key_name!
    formatted_friendly = self.name.extend(Helper::String).to_key_name
    return formatted_friendly if !self.class.exists?(:key_name => formatted_friendly)
    n = 1
    new_friendly = "%s_%s" % [formatted_friendly, n.to_s]
    n += 1 while self.class.exists?(:key_name => new_friendly)
    return "%s_%s" % [formatted_friendly, n.to_s]
  end
  
  def before_save
    self.key_name     = self.generate_key_name!
    self.url_friendly = self.generate_url_friendly!
  end
end
class Format::Url
  VALID_FORMAT = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
  
  def initialize(options = {})
    options.symbolize_keys!
    options.assert_valid_keys(:url)
    @attributes = options
  end
  
  class << self    
    def valid?(url)
      !url.match(self::VALID_FORMAT).blank?
    end
  end
  
  def id
    self.url
  end
  
  def url
    @attributes[:url]
  end
  
  def valid?
    self.class.valid?(self.url)
  end
end